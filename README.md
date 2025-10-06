# Digit Analysis (x86 Assembly + C)

Analyze ordered digit triples `d1 d2 d3` (with `d1 ≤ d2 ≤ d3`) using three hand‑written x86 (32‑bit) assembly routines called from a tiny C driver.

The program:
- Prints `PT` (Pythagorean Triple) when `d1² + d2² − d3² == 0`.
- Prints `ED` (Evenly Divisible) when `sum(d1,d2,d3) != 0`, `product(d1,d2,d3) != 0`, and `product % sum == 0`.

> Example outputs you should see:
>
> - `345 PT` because `3² + 4² − 5² = 0`  
> - `123 ED` because `(1·2·3) % (1+2+3) = 6 % 6 = 0`

---

## Files

```
src/
├─ Fernandes_2730_001_02.s     # Assembly: dodiff, dosumprod, doremainder
└─ BLANK_2730_001_02.c         # C driver (loops over 000..999 with d1 ≤ d2 ≤ d3)
```

### Symbols shared between C and ASM

The assembly declares the following 32‑bit globals (4‑byte `int`):
- `digit1, digit2, digit3` – current digits (set by the C driver)
- `diff, sum, product, remainder` – results written by the assembly routines

### Assembly routines

- `void dodiff(void);`  
  Computes `diff = digit1*digit1 + digit2*digit2 − digit3*digit3`.

- `void dosumprod(void);`  
  Computes `sum = digit1 + digit2 + digit3` and `product = digit1 * digit2 * digit3`.

- `void doremainder(void);`  
  Computes `remainder = product % sum` (assumes `sum != 0` and `product != 0`).

> Implementation notes: written for GAS (GNU assembler) with AT&T syntax (`movl src, dst`, registers like `%eax`).  
> Globals are exported with `.comm name, 4, 4`. Functions are labeled with `.globl name` and `.type name, @function`.

---

## Build & Run

This project targets **32‑bit x86** using **GCC + GAS**. On modern 64‑bit Linux, install multilib support first:

```bash
# Debian/Ubuntu
sudo apt-get update
sudo apt-get install gcc-multilib
```

### One‑liner build

```bash
gcc -m32 -no-pie src/BLANK_2730_001_02.c src/Fernandes_2730_001_02.s -o digit-analysis
```

- `-m32`    → build 32‑bit objects and link against 32‑bit libc
- `-no-pie` → some distros default to PIE; this avoids relocation issues for 32‑bit mixes

> If your compiler treats missing prototypes as errors, add these to the top of the C file:
> ```c
> void dodiff(void);
> void dosumprod(void);
> void doremainder(void);
> ```

### Run

```bash
./digit-analysis
```

You’ll see lines like:

```
345 PT
123 ED
...
```

> The loop only enumerates non‑decreasing triples (`d1 ≤ d2 ≤ d3`), so you won’t get permutations like `534` for `PT`.

---

## How it works (quick tour)

1. **C driver** sets `digit1`, `digit2`, `digit3` from `000` up to `999` while enforcing `digit1 ≤ digit2 ≤ digit3`.
2. Calls `dodiff()` → C prints `PT` if `diff == 0`.
3. Calls `dosumprod()` → if both `sum` and `product` are non‑zero, calls `doremainder()`.
4. C prints `ED` when `remainder == 0`.

Register‑level highlights in the assembly:
- Uses 32‑bit integer ops (`movl`, `imull`, `addl`, `subl`, `idivl`) and the `%eax/%edx` dividend pair for modulus.
- Communicates with C exclusively via the named globals above—no parameters are passed on the stack.

---

## Testing ideas

- Spot‑check known Pythagorean triples: `345`, `6810` (out of single‑digit range, so it won’t appear), etc.
- Verify ED cases like `123`, `246`.
- Add a small harness to assert expected flags for hand‑picked inputs.

---

## Portability

- **Linux (recommended):** GCC + GAS work out of the box with `-m32` + multilib.
- **macOS:** 32‑bit userland support was removed; use Docker/WSL or a Linux VM.
- **Windows:** Use WSL (Ubuntu) or MSYS2 with 32‑bit toolchain packages.

---

## Author

Aidan Fernandes — ECE 2730 (Section 001)

---

## License

If this is coursework, follow your class collaboration policy. Otherwise, consider MIT:

```
MIT License © Aidan Fernandes
```

