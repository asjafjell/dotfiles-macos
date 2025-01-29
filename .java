echo "Current available Java virtual machines:"
ls /Library/Java/JavaVirtualMachines

echo "Running Jenv Doctor:"
jenv doctor

jenv add /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home

eval "$(jenv init -)" && jenv enable-plugin maven
eval "$(jenv init -)" && jenv enable-plugin export
