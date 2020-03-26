#while true
#do
    #before=$(cat framecount.txt)
    #sleep 10
    #after=$(cat framecount.txt)
    #echo "print(($after - $before)/10)" | python3
    #echo $(((after - before) / 10))
#done
#!/bin/bash
#for i in 0 1 2 3 4 5 6 7 8 9 10
#do
#./setfreq.sh 1 $i 0 10
sleep 10
before=$(cat framecount.txt)
sleep 30
after=$(cat framecount.txt)
echo "print(($after - $before)/30)" | python3
#done
