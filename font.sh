#!/bin/bash
#-------------------------------
#	Created By Mizanur Rahman [3rR0r PriNc3]
#
#	Get me by bcmrashed@gmail.com or 3rr0r.pr1nc3@gmail.com if you want to ...
#-------------------------------

echo "Welcome to https://github.com/3rR0r-Pr1Nc3!!!"
echo "------------------------------------"
echo "Now starting to download and install all bangla fonts..........."
echo "------------------------------------"


# Variables
downloadUrls=("http://www.fahadahammed.com/extras/fonts/archieve/lsaBanglaFonts.tar.gz" "https://raw.githubusercontent.com/fahadahammed/linux-bangla-fonts/master/archieve/lsaBanglaFonts.tar.gz")
finalurl="" # it will select lowest latency mirror



# Get arrays of latency and plain urls.
point=()
pointPlus=()
finalu=()

for i in ${downloadUrls[@]};do 
  a=$(echo $i | sed 's|http://||g' | sed 's|https://||g' | cut -d '/' -f -1)
  aa=$(ping -c 5 "$a" | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  aaa=${aa%.*}
  point+=("$aaa")
  pointPlus+=("$aaa,$a")
  finalu+=("$aaa,$i")
done





# Calculate Minimum Latency
#---------------------------
max=${point[0]}
min=${point[0]}

echo $min
# Loop through all elements in the array
for i in "${finalu[@]}"
do
    a=$(echo $i | cut -d ',' -f 1)
    # Update max if applicable
    if [[ "$a" -gt "$max" ]]; then
        max="$i"
    fi

    # Update min if applicable
    if [[ "$a" -lt "$min" ]]; then
        min="$i"
    fi
done
finalurl=$(echo $min | cut -d ',' -f 2)







if [ $USER = "root" ]; then
  fontsDir="/root/.fonts/lsaBanglaFonts"
fi
if [ $USER != "root" ]; then
  fontsDir="/home/$USER/.fonts/lsaBanglaFonts"
fi




echo -e "\n"

if [ ! -d "$fontsDir" ]; then
  mkdir -p $fontsDir
else
  echo -e "Upgrading bangla fonts provided by us....\n";
  rm -r $fontsDir;
fi

echo -e "\n"
echo -e "Downloading the fonts compressed file....\n"
echo -e "\n"
echo $finalurl
wget -v -P $fontsDir"/" $finalurl

cd $fontsDir"/"
tar -zxvf lsaBanglaFonts.tar.gz
rm lsaBanglaFonts.tar.gz

cd

echo -e "\n"
echo -e "Initiating font refresh......\n"
fc-cache -f -v
echo -e "\n"

echo "------------------------------------"
echo "Bangla Font Installation Complete...... Welcome To Error Prince Bangla Font Modifiyer !!!"
echo -e "Script is Created by Mizanur Rahman [3rR0r Pr1Nc3]\n"
echo -e "Website: https://github.com/3rR0r-Pr1Nc3\n"
