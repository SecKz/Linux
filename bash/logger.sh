#!/bin/sh
# 以从命令行直接向系统日志文件（或者自定义的文件）写入一行信息。
# http://www.chenqing.org/2012/08/use-logger-logrotate-manage-your-logs.html
logger -i -t 'tag' -p local3.notice " $0 some error in …"
echo "Hello world"