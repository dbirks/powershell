sudo nmap -n -sP 192.168.8.8/23 | awk '/Nmap scan report/{printf $5;printf " ";getline;getline;print $3;}'
