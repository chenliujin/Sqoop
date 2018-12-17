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

def cube_refresh(cube, startTime, endTime):
  url = 'http://www.chenliujin.com/kylin/api/cubes/' + cube + '/build'

  auth=('ADMIN', 'KYLIN')

  headers = {
    "Content-Type": "application/json;charset=UTF-8"
  }

  data = {
      "startTime": startTime,
      "endTime": endTime,
      "buildType": "REFRESH"
  }

  r = requests.put(url, headers=headers, auth=auth, data=json.dumps(data))

  print(r.status_code)



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

for segment in rs[0]['segments']:
  for input in args.inputs:
    t = int(time.mktime(time.strptime(input + ' 08:00:00', '%Y-%m-%d %H:%M:%S')) * 1000)

    if segment['date_range_start'] <= t and t < segment['date_range_end'] :
      results[segment['date_range_start']] = {"startTime": segment['date_range_start'], "endTime": segment['date_range_end']}
    # 不存在，build 新的 segment

for result in results:
  cube_refresh('price_distribute', result['startTime'], result['endTime'])
