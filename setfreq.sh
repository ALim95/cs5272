# Initializing for LITTLE cluster
sudo bash -c 'echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor'
sudo bash -c 'echo 100000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq'

# Initializing for BIG cluster
sudo bash -c 'echo userspace > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor'
sudo bash -c 'echo 100000 > /sys/devices/system/cpu/cpufreq/policy2/scaling_min_freq'

# Initialize BIG and LITTLE cluster to use max speed
big_freq=1800000
little_freq=1896000

# Getting hexadecimal value for taskset for CPU allocation
num_big=$1
num_little=$3
taskset_hexa="3f"
if [ "$num_big" == "0" ]
then
    if [ "$num_little" == "1" ]
    then
        taskset_hexa="1"
    elif [ "$num_little" == "2" ]
    then
	taskset_hexa="3"
    fi
elif [ "$num_big" == "1" ]
then
    if [ "$num_little" == "0" ]
    then
	taskset_hexa="4"
    elif [ "$num_little" == "1" ] 
    then
        taskset_hexa="5"
    elif [ "$num_little" == "2" ]
    then
	taskset_hexa="7"
    fi
elif [ "$num_big" == "2" ]
then
    if [ "$num_little" == "0" ]
    then
	taskset_hexa="c"
    elif [ "$num_little" == "1" ] 
    then
        taskset_hexa="d"
    elif [ "$num_little" == "2" ]
    then
	taskset_hexa="f"
    fi
elif [ "$num_big" == "3" ]
then
    if [ "$num_little" == "0" ]
    then
	taskset_hexa="1c"
    elif [ "$num_little" == "1" ] 
    then
        taskset_hexa="1d"
    elif [ "$num_little" == "2" ]
    then
	taskset_hexa="1f"
    fi
elif [ "$num_big" == "4" ]
then
    if [ "$num_little" == "0" ]
    then
	taskset_hexa="3c"
    elif [ "$num_little" == "1" ] 
    then
        taskset_hexa="3d"
    elif [ "$num_little" == "2" ]
    then
	taskset_hexa="3f"
    fi
fi

pid=$(pidof DisplayImage)

taskset -p $taskset_hexa $pid

# Getting frequency value (0 to 10) for BIG and LITTLE
case "$2" in
    "0") big_freq=100000
    ;;
    "1") big_freq=250000
    ;;
    "2") big_freq=500000
    ;;
    "3") big_freq=667000
    ;;
    "4") big_freq=1000000
    ;;
    "5") big_freq=1200000
    ;;
    "6") big_freq=1398000
    ;;
    "7") big_freq=1512000
    ;;
    "8") big_freq=1608000
    ;;
    "9") big_freq=1704000
    ;;
    "10") big_freq=1800000
    ;;
esac

case "$4" in
    "0") little_freq=100000
    ;;
    "1") little_freq=250000
    ;;
    "2") little_freq=500000
    ;;
    "3") little_freq=667000
    ;;
    "4") little_freq=1000000
    ;;
    "5") little_freq=1200000
    ;;
    "6") little_freq=1398000
    ;;
    "7") little_freq=1512000
    ;;
    "8") little_freq=1608000
    ;;
    "9") little_freq=1704000
    ;;
    "10") little_freq=1860000
    ;;
esac

export big_freq
export little_freq

sudo -E bash -c 'echo -e "$big_freq" > /sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed'
sudo -E bash -c 'echo -e "$little_freq" > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed'

echo "BIG frequency is: $big_freq"
echo "LITTTLE frequency is: $little_freq"
