#!/bin/bash

# 重命名文件
rename_files() {
  local pattern="$1"
  local replacement="$2"
  local file_list=$(find TOSClientKit/Classes/ThirdLibs/YYKit -name "${pattern}*.h" -o -name "${pattern}*.m" | grep -v "$replacement")
  
  for file in $file_list; do
    local dir=$(dirname "$file")
    local filename=$(basename "$file")
    local new_filename=${filename/$pattern/$replacement}
    local new_path="$dir/$new_filename"
    
    echo "Renaming $file to $new_path"
    cp "$file" "$new_path"
    
    # 修改文件内容，将类名前缀从YY改为TIMYY
    sed -i '' "s/@interface $pattern/@interface $replacement/g" "$new_path"
    sed -i '' "s/@implementation $pattern/@implementation $replacement/g" "$new_path"
    sed -i '' "s/$pattern \*/$replacement */g" "$new_path"
    sed -i '' "s/\[$pattern /\[$replacement /g" "$new_path"
    sed -i '' "s/($pattern *)/(${replacement} *)/g" "$new_path"
    sed -i '' "s/<$pattern>/<$replacement>/g" "$new_path"
    sed -i '' "s/$pattern\.h/$replacement.h/g" "$new_path"
    sed -i '' "s/\#import \"$pattern/\#import \"$replacement/g" "$new_path"
    
    # 不要删除原文件，因为我们需要保持兼容性
    # rm "$file"
  done
}

# 所有以YY开头的.h和.m文件
rename_files "YY" "TIMYY"

echo "Renaming completed!" 