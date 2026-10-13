compile_file(){
	local file_path=$1
	echo "Compiling ${file_path}.asm ..."

	# Compile
	nasm -f elf64 ${file_path}.asm -o ${file_path}.o

	# Check for the error
	if [ $? -ne 0 ]; then
		echo "!! NASM compilation failed."
		exit 1
	fi
}

# Compile List

compile_file type_converters
compile_file ../Std_io/std_io
compile_file main

echo "Compilation complete"
