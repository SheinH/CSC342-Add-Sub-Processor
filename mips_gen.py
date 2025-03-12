#!/usr/bin/env python3

def int_to_bin_str(val, bits):
    if val < 0 or val >= (1 << bits):
        raise ValueError(f"Value {val} cannot be represented with {bits} bits.")
    return format(val, f'0{bits}b')

def main():
    print("Choose your instruction type:")
    print("1: add")
    print("2: subtract")
    print("3: addu")
    print("4: subu")
    choice = input("Enter the number corresponding to your choice: ").strip()
    if choice == "1":
        op = "add"
    elif choice == "2":
        op = "sub"
    elif choice == "3":
        op = "addu"
    elif choice == "4":
        op = "subu"
    else:
        print("Invalid choice!")
        return

    opcodes = {
        "add": "100000",
        "sub": "100010",
        "addu": "100001",
        "subu": "100011"
    }
    opcode = opcodes[op]
    try:
        rs_dec = int(input("Enter the first operand register (rs) in decimal (0-31): ").strip())
        rt_dec = int(input("Enter the second operand register (rt) in decimal (0-31): ").strip())
        rd_dec = int(input("Enter the destination register (rd) in decimal (0-31): ").strip())
    except ValueError:
        print("Invalid register entry. Please enter a valid number.")
        return

    try:
        rs_bin = int_to_bin_str(rs_dec, 5)
        rt_bin = int_to_bin_str(rt_dec, 5)
        rd_bin = int_to_bin_str(rd_dec, 5)
    except ValueError as ve:
        print(ve)
        return

    funct = "000000"
    shamt = "00000"
    instruction = opcode + rs_bin + rt_bin + rd_bin + shamt + funct
    print("\nYour 32-bit instruction literal is:")
    print(instruction)
    print("\n-- Field breakdown --")
    print(f"opcode (bits 31-26): {opcode}")
    print(f"rs (bits 25-21): {rs_bin}")
    print(f"rt (bits 20-16): {rt_bin}")
    print(f"rd (bits 15-11): {rd_bin}")
    print(f"shamt (bits 10-6) : {shamt}")
    print(f"funct (bits 5-0) : {funct}")

if __name__ == "__main__":
    main()