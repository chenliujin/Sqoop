#!/usr/bin/python3
import argparse
import requests
import time
import json

# Param

parser = argparse.ArgumentParser(description='')
parser.add_argument('--inputs', type=str, nargs='+', help='增量更新过的日期，用来刷新 cube 对应的 segment')
args = parser.parse_args()


# function

def build_cube(cube, startTime, endTime, buildType):
  url = 'http://www.chenliujin.com/kylin/api/cubes/' + cube + '/build'

  auth=('ADMIN', 'KYLIN')

  headers = {
    "Content-Type": "application/json;charset=UTF-8"
  }

  data = {
      "startTime": startTime,
      "endTime": endTime,
      "buildType": buildType 
  }

  r = requests.put(url, headers=headers, auth=auth, data=json.dumps(data))

  print('=== build cube: ' + cube + ' ' + buildType + ' ===')
  print('status code: ' + str(r.status_code))

# 传入日期数组
# 获取 segment 列表
# 有，refresh segment
# 无，build segment

url = 'http://www.chenliujin.com/kylin/api/cubes'

auth=('ADMIN', 'KYLIN')

params = {
    "projectName": "stock",
    "cubeName": "price_distribute"
}

r = requests.get(url, params, auth=auth)

rs = r.json()

results = {}

for input in args.inputs:

  exist = 0
  startTime = 0

  for segment in rs[0]['segments']:
    t = int(time.mktime(time.strptime(input + ' 08:00:00', '%Y-%m-%d %H:%M:%S')) * 1000)

    if 'endTime' not in vars():
      endTime = t;

    if segment['date_range_start'] <= t and t < segment['date_range_end'] :
      exist = 1
      results[segment['date_range_start']] = {
          "startTime": segment['date_range_start'], 
          "endTime": segment['date_range_end'],
          "buildType": 'REFRESH'
      }
    elif segment['date_range_end'] <= t and startTime < segment['date_range_end']:
      startTime = segment['date_range_end']

  if exist == 0 : # 不存在，build 新的 segment

    if startTime in results.keys() and 'endTime' in results[startTime].keys() and results[startTime]['endTime'] < t:
      endTime = t;

    results[startTime] = {
        "startTime": startTime, 
        "endTime": endTime, 
        "buildType": 'BUILD'
    }

  #print('ERROR: cube not exists!')
  #print(startTime)
  #print(t)

#print(results)



for result in results.values():
  build_cube('price_distribute', result['startTime'], result['endTime'], result['buildType'])
