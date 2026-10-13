echo "Build start"
ld type_converters.o ../Std_io/std_io.o main.o -o program

if [ $? -ne 0 ]; then
	echo "!! Build failed."
	exit 1
fi

echo "Build complete"
