def create_and_write_numbers():
    file_name = 'numbers.txt'
    
    try:
        with open(file_name, 'w') as file:
            for number in range(1, 101):
                file.write(str(number) + '\n')
        print(f"Numbers 1 to 100 have been written to {file_name} successfully.")
    except IOError:
        print(f"Error: Failed to create or write to {file_name}.")

create_and_write_numbers()
