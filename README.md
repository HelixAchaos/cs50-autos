# cs50-autos
`check50 path` and `wget url` are pretty tedious to type and remember. This automates it. Why type more characters than necessary?

Note: This is tested for ide.cs50.io, not for the other service.

### Setup:
1. Get the file to `~/` (`/home/ubuntu/`)
2. run `source .bashrc` in the terminal

### How to Use:
  I find it best to just use examples.
1. For PSet 1 - Cash:
      1. If you haven't already made a directory for the 2nd problem sets, run `mkdir pset2`.
      2. `cd pset2`
      3. Run `mkcd cash`.
      * Comments: This just opens a file with the typical boilerplate one needs to start a file.

2. For PSet 3 - Runoff:
      1. If you haven't already made a directory for the 3rd problem sets, run `mkdir pset3`.
      2. `cd pset3`
      3. Run `mkcd runoff -wget`.
      * Comments: This downloads the given file, and moves it to the proper directory.
      
3. For PSet 5 - Speller:
      1. If you haven't already made a directory for the 5th problem sets, run `mkdir pset5`.
      2. `cd pset5`
      3. Run `mkcd speller -wget`.
      * Comments: This downloads and unzips the given zip file. If there is a .c file in the unzipped, then it will be opened.


Tasks:
- [ ] Test/Make version for the GitHub Sandbox
- [ ] do `mkdir/cd pset{n}` with `mkcd`
- [ ] Test out `~/ps6/dna/ mkcd dna -wget -py`. -wget fails . `~/ mkcd dna -wget -py && mv /home/ubuntu/dna /home/ubuntu/ps6/dna` works.
- [ ] wget urls -> {zip|c/py} {$comfort_version, null};   no need to try so many urls
