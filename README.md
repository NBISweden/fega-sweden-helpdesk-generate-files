# Workflow for generating FASTQ files

Snakemake workflow to generate artificial files in FASTQ format for testing
purposes. This workflow ensures that the files not only are given unique
filenames, but also that the sequence identifiers within the files are unique
(the generated files will thus have different checksums).

By providing a prefix to the filenames and sequence identifiers, you can ensure 
that files differ between runs. The workflow will use a timestamp as
prefix by default. By default, the workflow will generate 4 files.


## Prerequisites

* Python 3
* Snakemake


## Usage

For running the workflow on a single core with default settings:

```
snakemake -c 1
```

Output files will be stored in a folder named `output/`.

To generate let say 20 files, you could enter the following 
command:

```
snakemake -c 1 --config numFiles=20
```

A timestamp will be prefixed to the resulting file names and sequence identifiers by default. If you wishm you can provide a custom prefix instead:

```
snakemake -c 1 --config prefix="submission1_" numFiles=20
```


## Post processing

If you want to compress each file separately, you can run the following
command inside the `output/` folder:

```
find . -type f -execdir tar -zcvf '{}.tar.gz' '{}' \;
```
