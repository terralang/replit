-- This top-level code is plain Lua code.
function printhello()
    -- This is a plain Lua function.
    print("Hello, Lua!")
end
printhello()
print()

-- Terra is backwards compatible with C, we'll use C's io library in
-- our example.
local C = terralib.includec("stdio.h")

-- The keyword 'terra' introduces a new Terra function.
terra hello(argc : int, argv : &rawstring)
    -- Here we call a C function from Terra.
    C.printf("Hello, Terra!\n")
    return 0
end

-- You can call Terra functions directly from Lua, they are JIT
-- compiled using LLVM to create machine code.
hello(0,nil)
print()

-- Terra functions are first-class values in Lua, and can be
-- introspected and meta-programmed using it.
print("Dissassembly of hello:")
hello:disas()
print()

-- You can save Terra code as executables, object files, or shared
-- libraries and link them into existing programs.
terralib.saveobj("helloterra",{ main = hello })

print("Running ./helloterra executable:")
os.execute("./helloterra")
