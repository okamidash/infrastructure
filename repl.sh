echo $1 $2

for i in $(grep -rl "$1"); do
    echo $i
    sed -i "s/$1/$2/g" $i
done
