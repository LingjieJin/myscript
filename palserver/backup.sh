#!/bin/sh
DDATE=$(date "+%F-%T")
NEW_DIR="/home/steamtest/palserver-save/$DDATE"
mkdir -p $NEW_DIR

# 拷贝文件夹
cp -r /home/steamtest/.steam/SteamApps/common/PalServer/Pal/Saved/SaveGames $NEW_DIR/

# 输出文件信息到txt文件
OUTPUT_FILE="$NEW_DIR/files_info.txt"
echo "Directory structure and file sizes:" > $OUTPUT_FILE
du -h $NEW_DIR >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
echo "File details:" >> $OUTPUT_FILE
ls -lR $NEW_DIR >> $OUTPUT_FILE

# 打包文件夹
tar -czf "${NEW_DIR}.tar.gz" $NEW_DIR
