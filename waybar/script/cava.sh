#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"
i=0
while [ $i -lt ${#bar} ]; do
  dict="${dict}s/$i/${bar:$i:1}/g;"
  i=$((i+1))
done

# write cava config (lower framerate, fewer bars)
config_file="/tmp/waybar_cava_config"
cat > "$config_file" <<'EOF'
[general]
framerate = 15        # <= 낮출수록 CPU 절약 (예: 10~20 권장)
bars = 10             # 막대 수를 줄이면 연산량 감소
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# run cava and map digits -> bars in a single sed process
cava -p "$config_file" | sed -u "$dict"
