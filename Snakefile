"""Create fastq files with unique names and unique content."""

from datetime import datetime


configfile: "config.yaml"

def fastq_as_str(seq_id):
    fastq = (
        f"@{seq_id}\n"
        f"GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT\n"
        f"+\n"
        f"!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65\n"
    )
    return fastq

if config["prefix"] is None:
    now = datetime.now()
    prefix = now.strftime("%Y%m%dT%H%M%S_")
else:
    prefix = config["prefix"]

assert config["numFiles"] <= 100000
seq_ids = [prefix + str(_).zfill(5) for _ in range(config["numFiles"])]

rule all:
    input: expand("output/{seq_id}.fastq", seq_id=seq_ids)


rule generate_fastq:
    output: "output/{seq_id}.fastq"
    run:
        with open(output[0], "w") as out:
            out.write(fastq_as_str(wildcards.seq_id))
