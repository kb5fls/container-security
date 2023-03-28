# Container image with malware and crypto miner for testing purposes

# This repository is courtesy of [ruzickap](https://github.com/ruzickap/malware-cryptominer-container)

# I used this project by connecting this repository to my GCP Kubernetes cluster pushing the container images to my GCP (gcr.io) repository and tested with [Trend Micro Cloud One Container Security](https://cloudone.trendmicro.com/docs/container-security/) and [Deep Security Smart Check](https://cloudone.trendmicro.com/docs/container-security/sc-about/) by deploying the malware crypto-miner container image and deploying Trend Micro Container Security and Deep Security Smartcheck for Proof of Concept (PoC).

# Additional Resources of Docker Images for Malware Analysis
# [**Docker Images of Malware Analysis Tools**](https://docs.remnux.org/run-tools-in-containers/remnux-containers)



[![Container build](https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml/badge.svg)](https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/malware-cryptominer-container)](https://artifacthub.io/packages/search?repo=malware-cryptominer-container)

![Ransomware](https://raw.githubusercontent.com/MISP/intelligence-icons/52d597bf00d58b92ee8809802b507c6d0755235f/svg/ransomware.svg)
![Malware](https://raw.githubusercontent.com/MISP/intelligence-icons/513abc840b7ac92e4f8a4a7ecab2964007bf25f5/svg/malware.svg)
![Threat Actor](https://raw.githubusercontent.com/MISP/intelligence-icons/513abc840b7ac92e4f8a4a7ecab2964007bf25f5/svg/threat_actor.svg)

- [Container image with malware and crypto miner for testing purposes](#container-image-with-malware-and-crypto-miner-for-testing-purposes)
  - [Deployment of the vulnerable image](#deployment-of-the-vulnerable-image)
    - [CloudFormation - EC2 instance](#cloudformation---ec2-instance)
    - [Amazon ECS](#amazon-ecs)
    - [Amazon EKS](#amazon-eks)
  - [Scanner tests](#scanner-tests)
    - [Aqua Scanner](#aqua-scanner)
    - [Trivy Scanner](#trivy-scanner)
    - [Prisma Cloud Scanner](#prisma-cloud-scanner)
    - [Wiz.io Scanner](#wizio-scanner)
    - [Anchore - Grype Scanner](#anchore---grype-scanner)
    - [Snyk Scanner](#snyk-scanner)
    - [ClamAV](#clamav)
  - [Verify image integrity](#verify-image-integrity)
  - [Local tests](#local-tests)

I decided to build minimal [nginx](https://hub.docker.com/_/nginx) based
[container image](https://quay.io/repository/petr_ruzicka/malware-cryptominer-container?tab=tags&tag=latest)
which contains malware / ransomware / crypto miner / ...

Security tools should be able to scan the image and discover harmful files.

> Running/starting the [container image](https://quay.io/repository/petr_ruzicka/malware-cryptominer-container?tab=tags)
> do not "activate" / "execute" the malware.

- Container Image:
  - [quay.io/petr_ruzicka/malware-cryptominer-container:2.0.0](https://quay.io/petr_ruzicka/malware-cryptominer-container:2.0.0)
- Container Registry:
  - <https://quay.io/repository/petr_ruzicka/malware-cryptominer-container?tab=tags>
- Container build pipeline:
  - <https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml>
- Dockerfile used for building the container:
  - <https://github.com/ruzickap/malware-cryptominer-container/blob/main/Dockerfile>

The malware files inside container image were downloaded from:

- [eicar](https://www.eicar.org/download-anti-malware-testfile/)
- [xmrig](https://xmrig.com/)
- <https://github.com/Da2dalus/The-MALWARE-Repo>
- <https://github.com/timb-machine/linux-malware>
- <https://github.com/antonioCoco/ConPtyShell>

The malware/crypto miner are located in the `/usr/share/nginx/html` directory:

```bash
/usr/share/nginx/html
├── ILOVEYOU.vbs                      [C source, ASCII text]
├── Invoke-ConPtyShell.ps1            [ASCII text, with very long lines (361)]
├── L0Lz.bat                          [DOS batch file, ASCII text]
├── Linux.Trojan.Multiverze.elf.x86   [ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, with debug_info, not stripped]
├── MadMan.exe                        [MS-DOS executable]
├── Melissa.doc                       [Composite Document File V2 Document, Little Endian, Os: Windows, Version 4.10, Code page: 1252, Title: Password List for March 26th 1999, Subject: Adult Website Passwords, Author: John Holmes, Keywords: 73 sites in this list, Comments: Password List for March 26th 1999, Template: Normal.dot, Last Saved By: Him, Revision Number: 2, Name of Creating Application: Microsoft Word 8.0, Create Time/Date: Fri Mar 26 11:39:00 1999, Last Saved Time/Date: Fri Mar 26 11:39:00 1999, Number of Pages: 2, Number of Words: 745, Number of Characters: 4249, Security: 0]
├── Py.Trojan.NecroBot.py             [Python script, ASCII text executable, with very long lines (4330), with CRLF line terminators]
├── TrojanSpy.MacOS.XCSSET.A          [Mach-O 64-bit x86_64 executable, flags:<NOUNDEFS|DYLDLINK|TWOLEVEL|PIE>]
├── Txt.Malware.Sustes.sh             [Bourne-Again shell script, ASCII text executable]
├── Unix.Downloader.Rocke.sh          [POSIX shell script, ASCII text executable]
├── Unix.Malware.Kaiji.elf.arm        [ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, Go BuildID=9fdmXJhReUX31Gj9ZEYg/ufudXOOpAambiyMItr13/otwZTTTdWsnO_OuvAAn-/qn6mMLxbKwGft_Ecoum6, stripped]
├── Unix.Trojan.Mirai.elf.m68k        [ELF 32-bit MSB executable, Motorola m68k, 68020, version 1 (SYSV), statically linked, stripped]
├── Unix.Trojan.Mirai.elf.mips        [ELF 32-bit MSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked, not stripped]
├── Unix.Trojan.Mirai.elf.ppc         [ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), statically linked, not stripped]
├── Unix.Trojan.Mirai.elf.sparc       [ELF 32-bit MSB executable, SPARC, version 1 (SYSV), statically linked, not stripped]
├── Unix.Trojan.Mirai.elf.x86_64      [ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, stripped]
├── Unix.Trojan.Spike.elf.arm         [ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, for GNU/Linux 2.6.16, with debug_info, not stripped]
├── Walker.com                        [DOS executable (COM), start instruction 0xe9cd04e8 5400e871]
├── WannaCry.exe                      [PE32 executable (GUI) Intel 80386, for MS Windows]
├── Win.Trojan.Perl.perl              [Perl script text executable]
├── Zloader.xlsm                      [Microsoft Excel 2007+]
├── eicar
│   ├── eicar.com                     [EICAR virus test files]
│   ├── eicar.com.txt                 [EICAR virus test files]
│   └── eicarcom2.zip                 [Zip archive data, at least v1.0 to extract]
└── xmrig
    ├── xmrig                         [ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, stripped]
    └── xmrig-linux-static-x64.tar.gz [gzip compressed data, last modified: Sun Oct 23 10:50:44 2022, from Unix, original size modulo 2^32 8898560]
```

List of malware/ransomware/crypto miner files:

- [ILOVEYOU.vbs](https://github.com/Da2dalus/The-MALWARE-Repo/blob/master/Email-Worm/ILOVEYOU.vbs)
  [C source, ASCII text]
  - [Virustotal](https://www.virustotal.com/gui/file/556700ac50ffa845e5de853498242ee5abb288eb5b8ae1ae12bfdb5746e3b7b1)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/556700ac50ffa845e5de853498242ee5abb288eb5b8ae1ae12bfdb5746e3b7b1)
- [Invoke-ConPtyShell.ps1](https://github.com/antonioCoco/ConPtyShell/blob/master/Invoke-ConPtyShell.ps1)
  [ASCII text, with very long lines (361)]
  - [Virustotal](https://www.virustotal.com/gui/file/90a17fd47fe1042cd86ae32fba8d9a5ccdef6162578d9c384fe534112700fb64)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/90a17fd47fe1042cd86ae32fba8d9a5ccdef6162578d9c384fe534112700fb64)
- [L0Lz.bat](https://github.com/Da2dalus/The-MALWARE-Repo/blob/master/Trojan/L0Lz.bat)
  [DOS batch file, ASCII text]
  - [Virustotal](https://www.virustotal.com/gui/file/fc94130b45112bdf7fe64713eb807f4958cdcdb758c25605ad9318cd5a8e17ae)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/fc94130b45112bdf7fe64713eb807f4958cdcdb758c25605ad9318cd5a8e17ae)
- [Linux.Trojan.Multiverze.elf.x86](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Linux.Trojan.Multiverze/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5.elf.x86)
  [ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), ...]
  - [Virustotal](https://www.virustotal.com/gui/file/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5)
- [MadMan.exe](https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Virus/MadMan.exe)
  [MS-DOS executable]
  - [Virustotal](https://www.virustotal.com/gui/file/17d81134a5957fb758b9d69a90b033477a991c8b0f107d9864dc790ca37e6a23)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/17d81134a5957fb758b9d69a90b033477a991c8b0f107d9864dc790ca37e6a23)
- [Melissa.doc](https://github.com/Da2dalus/The-MALWARE-Repo/blob/master/Virus/Melissa.doc)
  [Composite Document File V2 Document, Little Endian, Os: Windows, Version
  4.10, ...]
  - [Virustotal](https://www.virustotal.com/gui/file/554701bc874da646285689df79e5002b3b1a1f76daf705bea9586640026697ca)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/554701bc874da646285689df79e5002b3b1a1f76daf705bea9586640026697ca)
- [Py.Trojan.NecroBot.py](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Py.Trojan.NecroBot/0e600095a3c955310d27c08f98a012720caff698fe24303d7e0dcb4c5e766322.py)
  [Python script, ASCII text executable, with very long lines (4330), with CRLF
  ...]
  - [Virustotal](https://www.virustotal.com/gui/file/0e600095a3c955310d27c08f98a012720caff698fe24303d7e0dcb4c5e766322)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/0e600095a3c955310d27c08f98a012720caff698fe24303d7e0dcb4c5e766322)
- [TrojanSpy.MacOS.XCSSET.A](https://github.com/Da2dalus/The-MALWARE-Repo/blob/master/Trojan/XCSSETMacMalware/TrojanSpy.MacOS.XCSSET.A.6614978ab256f922d7b6dbd7cc15c6136819f4bcfb5a0fead480561f0df54ca6)
  [Mach-O 64-bit x86_64 executable, flags:<NOUNDEFS|DYLDLINK|...>]
  - [Virustotal](https://www.virustotal.com/gui/file/6614978ab256f922d7b6dbd7cc15c6136819f4bcfb5a0fead480561f0df54ca6)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/6614978ab256f922d7b6dbd7cc15c6136819f4bcfb5a0fead480561f0df54ca6)
- [Txt.Malware.Sustes.sh](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Txt.Malware.Sustes/0e77291955664d2c25d5bfe617cec12a388e5389f82dee5ae4fd5c5d1f1bdefe.sh)
  [Bourne-Again shell script, ASCII text executable]
  - [Virustotal](https://www.virustotal.com/gui/file/0e77291955664d2c25d5bfe617cec12a388e5389f82dee5ae4fd5c5d1f1bdefe)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/0e77291955664d2c25d5bfe617cec12a388e5389f82dee5ae4fd5c5d1f1bdefe)
- [Unix.Downloader.Rocke.sh](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Downloader.Rocke/228ec858509a928b21e88d582cb5cfaabc03f72d30f2179ef6fb232b6abdce97.sh)
  [POSIX shell script, ASCII text executable]
  - [Virustotal](https://www.virustotal.com/gui/file/228ec858509a928b21e88d582cb5cfaabc03f72d30f2179ef6fb232b6abdce97)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/228ec858509a928b21e88d582cb5cfaabc03f72d30f2179ef6fb232b6abdce97)
- [Unix.Malware.Kaiji.elf.arm](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Malware.Kaiji/3e68118ad46b9eb64063b259fca5f6682c5c2cb18fd9a4e7d97969226b2e6fb4.elf.arm)
  [ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked,
  ...]
  - [Virustotal](https://www.virustotal.com/gui/file/3e68118ad46b9eb64063b259fca5f6682c5c2cb18fd9a4e7d97969226b2e6fb4)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/3e68118ad46b9eb64063b259fca5f6682c5c2cb18fd9a4e7d97969226b2e6fb4)
- [Unix.Trojan.Mirai.elf.m68k](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/11242cdb5dac9309a2f330bd0dad96efba9ccc9b9d46f2361e8bf8e4cde543c1.elf.m68k)
  [ELF 32-bit MSB executable, Motorola m68k, 68020, version 1 (SYSV), ...]
  - [Virustotal](https://www.virustotal.com/gui/file/11242cdb5dac9309a2f330bd0dad96efba9ccc9b9d46f2361e8bf8e4cde543c1)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/11242cdb5dac9309a2f330bd0dad96efba9ccc9b9d46f2361e8bf8e4cde543c1)
- [Unix.Trojan.Mirai.elf.mips](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/faa0deaba42ba76192609c5d2f59664e871c7bc68ebb5d99c91bf8ea4ddb8ea5.elf.mips)
  [ELF 32-bit MSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked,
  ...]
  - [Virustotal](https://www.virustotal.com/gui/file/faa0deaba42ba76192609c5d2f59664e871c7bc68ebb5d99c91bf8ea4ddb8ea5)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/faa0deaba42ba76192609c5d2f59664e871c7bc68ebb5d99c91bf8ea4ddb8ea5)
- [Unix.Trojan.Mirai.elf.ppc](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/d5230c95c4af4e1fcddf9660070932b7876a9569dc3a2baedf762abbe37b1ad5.elf.ppc)
  [ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV),
  ...]
  - [Virustotal](https://www.virustotal.com/gui/file/d5230c95c4af4e1fcddf9660070932b7876a9569dc3a2baedf762abbe37b1ad5)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/d5230c95c4af4e1fcddf9660070932b7876a9569dc3a2baedf762abbe37b1ad5)
- [Unix.Trojan.Mirai.elf.sparc](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/190333b93af51f9a3e3dc4186e4f1bdb4f92c05d3ce047fbe5c3670d1b5a87b4.elf.sparc)
  [ELF 32-bit MSB executable, SPARC, version 1 (SYSV), statically linked, ...]
  - [Virustotal](https://www.virustotal.com/gui/file/190333b93af51f9a3e3dc4186e4f1bdb4f92c05d3ce047fbe5c3670d1b5a87b4)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/190333b93af51f9a3e3dc4186e4f1bdb4f92c05d3ce047fbe5c3670d1b5a87b4)
- [Unix.Trojan.Mirai.elf.x86_64](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/40e8d9d82800728a5f1cfc2c2e156d5ee72fb44c54c26a86cfd35e95ea737e37.elf.x86_64)
  [ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked,
  ...]
  - [Virustotal](https://www.virustotal.com/gui/file/40e8d9d82800728a5f1cfc2c2e156d5ee72fb44c54c26a86cfd35e95ea737e37)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/40e8d9d82800728a5f1cfc2c2e156d5ee72fb44c54c26a86cfd35e95ea737e37)
- [Unix.Trojan.Spike.elf.arm](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Spike/04d88a0f5ffa8da57cfd9b1ae6e4fd9758610a3de72688516b258b5564735476.elf.arm)
  [ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked,
  ...]
  - [Virustotal](https://www.virustotal.com/gui/file/04d88a0f5ffa8da57cfd9b1ae6e4fd9758610a3de72688516b258b5564735476)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/04d88a0f5ffa8da57cfd9b1ae6e4fd9758610a3de72688516b258b5564735476)
- [Walker.com](https://github.com/Da2dalus/The-MALWARE-Repo/blob/master/Virus/Walker.com)
  [DOS executable (COM)]
  - [Virustotal](https://www.virustotal.com/gui/file/b87b48dcbf779b06c6ca6491cd31328cf840578d29a6327b7a44f9043ce1eb07)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/b87b48dcbf779b06c6ca6491cd31328cf840578d29a6327b7a44f9043ce1eb07)
- [WannaCry.exe](https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Ransomware/WannaCry.exe)
  [PE32 executable (GUI) Intel 80386, for MS Windows]
  - [Virustotal](https://www.virustotal.com/gui/file/be22645c61949ad6a077373a7d6cd85e3fae44315632f161adc4c99d5a8e6844)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/be22645c61949ad6a077373a7d6cd85e3fae44315632f161adc4c99d5a8e6844)
- [Zloader.xlsm](https://github.com/Da2dalus/The-MALWARE-Repo/blob/master/Banking-Malware/Zloader.xlsm)
  [Microsoft Excel 2007+]
  - [Virustotal](https://www.virustotal.com/gui/file/90c03a8ca35c33aad5e77488625598da6deeb08794e6efc9f1ddbe486df33e0c)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/90c03a8ca35c33aad5e77488625598da6deeb08794e6efc9f1ddbe486df33e0c)
- [Win.Trojan.Perl.perl](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Win.Trojan.Perl/9aed7ab8806a90aa9fac070fbf788466c6da3d87deba92a25ac4dd1d63ce4c44.perl)
  [Perl script text executable]
  - [Virustotal](https://www.virustotal.com/gui/file/9aed7ab8806a90aa9fac070fbf788466c6da3d87deba92a25ac4dd1d63ce4c44)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/9aed7ab8806a90aa9fac070fbf788466c6da3d87deba92a25ac4dd1d63ce4c44)
- [eicar](https://secure.eicar.org/eicar.com)
  [EICAR virus test files]
  - [Virustotal](https://www.virustotal.com/gui/file/275a021bbfb6489e54d471899f7db9d1663fc695ec2fe2a2c4538aabf651fd0f)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/275a021bbfb6489e54d471899f7db9d1663fc695ec2fe2a2c4538aabf651fd0f/)
- [xmrig](https://xmrig.com/)
  [ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, stripped]
  - [Virustotal](https://www.virustotal.com/gui/file/0ad68d5804804c25a6f6f3d87cc3a3886583f69b7115ba01ab7c6dd96a186404)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/0ad68d5804804c25a6f6f3d87cc3a3886583f69b7115ba01ab7c6dd96a186404)

## Deployment of the vulnerable image

There are several ways how to run the "malware container image" and there are
few of them.

### CloudFormation - EC2 instance

Run the EC2 instance with docker and the [quay.io/petr_ruzicka/malware-cryptominer-container](https://quay.io/repository/petr_ruzicka/malware-cryptominer-container?tab=tags)
container with SSM enabled (only console access):

```bash
export AWS_DEFAULT_REGION="eu-central-1"

aws cloudformation deploy --capabilities CAPABILITY_IAM \
 --stack-name ${USER}-malware-cryptominer-container-ec2 \
 --parameter-overrides "ContainerImage=quay.io/petr_ruzicka/malware-cryptominer-container:2.0.0" \
 --template-file EC2InstanceWithDockerSample.yaml \
 --tags "Name=${USER}-malware-cryptominer-container-ec2"

# aws cloudformation delete-stack --stack-name ${USER}-malware-cryptominer-container-ec2
```

### Amazon ECS

[Copilot](https://aws.amazon.com/blogs/containers/introducing-aws-copilot/)
example:

```bash
export AWS_DEFAULT_REGION="eu-central-1"

copilot init --app "${USER}-malware-cryptominer-app" --name "${USER}-malware-cryptominer" \
  --image quay.io/petr_ruzicka/malware-cryptominer-container:2.0.0 \
  --type 'Load Balanced Web Service' --port 8080 --deploy

# copilot app delete --name "${USER}-malware-cryptominer-app"
```

### Amazon EKS

Run simple [Amazon EKS](https://aws.amazon.com/eks/) cluster with "malware pod":

```bash
export AWS_DEFAULT_REGION="eu-central-1"
export CLUSTER_NAME="${USER}-malware-cryptominer-eks"
export KUBECONFIG="/tmp/kubeconfig-${CLUSTER_NAME}.conf"

eksctl create cluster --name "${CLUSTER_NAME}" --instance-types t3a.small --kubeconfig "${KUBECONFIG}"
kubectl run malware-cryptominer --image=quay.io/petr_ruzicka/malware-cryptominer-container:2.0.0

# eksctl delete cluster --name "${CLUSTER_NAME}"
```

## Scanner tests

Few scanners which I used to identify the problems inside container image.
(results will change in the future)

- Scanner tests were executed on: `2023-01-04`
- Image version: `quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0`

### Aqua Scanner

```bash
❯ docker pull quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
❯ docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock registry.aquasec.com/scanner:2022.4 \
  -H https://xxxxxxxxx.cloud.aquasec.com -U 'ruzickap-scanner-test' -P 'xxxxxxx' \
  scan --local --scan-malware --collect-sensitive quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
2023-01-04 10:08:41.610   INFO    Logger started with level INFO
2023-01-04 10:08:46.642   INFO    Registering with server {"os": "linux", "os_version": "", "registries": []}
2023-01-04 10:08:46.846   INFO    Successfully registered {"scanner_id": 13712}
2023-01-04 10:08:47.372   INFO    Starting Scan Image {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c"}
2023-01-04 10:08:47.696   INFO    Start getting image information from registry... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397"}
2023-01-04 10:08:47.698   INFO    Connecting to registry... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397"}
2023-01-04 10:08:47.703   INFO    Requesting authorization to pull image... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397"}
2023-01-04 10:08:47.822   INFO    Getting image manifest... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397"}
2023-01-04 10:08:47.827   INFO    Found several platforms matching request, choosing first one {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "selected": "amd64::linux:", "matches": ["amd64::linux:"]}
2023-01-04 10:08:47.827   INFO    Getting image history... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:47.827   INFO    Getting image metadata... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:47.928   INFO    Working with Layer Digest Ids {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:47.930   INFO    End getting image information from registry... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 0}
2023-01-04 10:08:47.930   INFO    Start getting assurance policies from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:47.930   INFO    Getting assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:48.128   INFO    End getting assurance policies from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 1}
2023-01-04 10:08:48.128   INFO    Start fetching security feed from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:48.229   INFO    Latest security feeds need to be pulled from server. {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:48.352   INFO    Latest security feeds need to be pulled from server. {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:48.472   INFO    Latest security feeds need to be pulled from server. {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:48.720   INFO    End fetching security feed from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 0}
2023-01-04 10:08:48.720   INFO    Start pulling image... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:48.720   INFO    Start pulling image in Dockerless mode... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:50.849   INFO    End pulling image in Dockerless mode... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 2}
2023-01-04 10:08:50.850   INFO    End pulling image {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 2}
2023-01-04 10:08:50.850   INFO    Start analyzing image layer by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:50.852   INFO    Start analyzing image by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:51.938   INFO    End analyzing image by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 1}
2023-01-04 10:08:51.939   INFO    End analyzing image layer by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:51.939   INFO    Contacting CyberCenter... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:52.390   INFO    Start merging layers analysis... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:52.390   INFO    End merging layers analysis... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 0}
2023-01-04 10:08:52.391   INFO    Start Contacting CyberCenter... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:52.617   INFO    End Contacting CyberCenter... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 0}
2023-01-04 10:08:52.618   INFO    Start processing results... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:52.728   INFO    End processing results... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 0}
2023-01-04 10:08:52.729   INFO    Start applying assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:52.932   INFO    Applying image assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:"}
2023-01-04 10:08:52.941   INFO    End applying assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0", "requested platform": "amd64:::", "job ID": "cf845f13-f22a-41bb-bc07-48e6ffe4e02c", "server version": "2022.4.21541ab397", "scanning platform": "amd64::linux:", "seconds": 0}
2023-01-04 10:08:54.782   INFO    Skipping file hash saving.
{
  "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0",
  "scan_started": {
    "seconds": 1672826927,
    "nanos": 372585185
  },
  "scan_duration": 5,
  "image_size": 30934357,
  "digest": "sha256:5ab315d3255b83f72c9352d901fd5610cead689f73ed792eb9a411d73a522fc4",
  "metadata": {
    "repo_digests": [
      "quay.io/petr_ruzicka/malware-cryptominer-container@sha256:1f742ffe4aceb94534d84be9b5935deca8b6f5a934d9306f433522d4924400a9"
    ]
  },
  "os": "alpine",
  "version": "3.17.0",
  "image_assurance_results": {
    "checks_performed": [
      {
        "policy_id": 265,
        "policy_name": "mypolicy",
        "control": "root_user"
      },
    ...
    ...
    ...
    ]
  },
  "vulnerability_summary": {},
  "scan_options": {
    "scan_executables": true,
    "scan_sensitive_data": true,
    "scan_malware": true,
    "scan_files": true,
    "scan_timeout": 3600000000000,
    "manual_pull_fallback": true,
    "save_adhoc_scans": true,
    "use_cvss3": true,
    "dockerless": true,
    "system_image_platform": "amd64:::",
    "telemetry_enabled": true,
    "scan_elf": true,
    "enable_fast_scanning": true,
    "memoryThrottling": true,
    "suggest_os_upgrade": true,
    "seim_enabled": true,
    "adhoc_scan_retention": 30
  },
  "initiating_user": "ruzickap-scanner-test",
  "data_date": 1672816984,
  "pull_name": "quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0",
  "scan_id": 1337258,
  "required_image_platform": "amd64:::",
  "scanned_image_platform": "amd64::linux:",
  "security_feeds_used": {
    "executables": "ef4e6ffe9e909f"
  },
  "image_id": 2294916,
  "internal_digest_id": {
    "id": 216918
  },
  "local": true,
  "OriginFromHostImage": true,
  "CanSkipFileHashSave": true
}
2023-01-04 10:08:54.919   INFO    Deregistering from console
2023-01-04 10:08:55.024   INFO    Scan successfully completed.
```

Details from "Aqua Images" section:

![Aqua - Image details](./img/aqua-image_details.avif)
![Aqua - Images](./img/aqua-images.avif)

Aqua details of container image running inside Amazon EKS cluster:

![Aqua - Container image running in Amazon EKS](./img/aqua-malware-cryptominer-details.avif)

### Trivy Scanner

Trivy web scan: <https://trivy.dev/results/?image=quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0>

```bash
❯ trivy image quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
2023-01-04T10:15:42.045Z   INFO    Vulnerability scanning is enabled
2023-01-04T10:15:42.046Z   INFO    Secret scanning is enabled
2023-01-04T10:15:42.047Z   INFO    If your scanning is slow, please try '--security-checks vuln' to disable secret scanning
2023-01-04T10:15:42.047Z   INFO    Please see also https://aquasecurity.github.io/trivy/v0.33/docs/secret/scanning/#recommendation for faster secret detection
2023-01-04T10:15:42.052Z   INFO    Detected OS: alpine
2023-01-04T10:15:42.052Z   INFO    This OS version is not on the EOL list: alpine 3.17
2023-01-04T10:15:42.052Z   INFO    Detecting Alpine vulnerabilities...
2023-01-04T10:15:42.054Z   INFO    Number of language-specific files: 0

quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0 (alpine 3.17.0)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

### Prisma Cloud Scanner

> Files are extracted to the disk, where the scanner is running
> (local "antivirus" will detect the extracted malware files)

```bash
❯ docker pull quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
❯ twistcli images scan --address=https://us-west1.cloud.twistlock.com/xxxxxxxxxxxxxx --details --user xxxx --password xxxx quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
Scan results for: image quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0 sha256:5ab315d3255b83f72c9352d901fd5610cead689f73ed792eb9a411d73a522fc4
Vulnerabilities
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
|      CVE       | SEVERITY | CVSS | PACKAGE | VERSION  |          STATUS          |  PUBLISHED  | DISCOVERED |                    DESCRIPTION                     |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-38297 | critical | 9.80 | go      | 1.14.4   | fixed in 1.17.2, 1.16.9  | > 1 years   | < 1 hour   | Go before 1.16.9 and 1.17.x before 1.17.2 has a    |
|                |          |      |         |          | > 1 years ago            |             |            | Buffer Overflow via large arguments in a function  |
|                |          |      |         |          |                          |             |            | invocation from a WASM module, when GOARCH=wasm    |
|                |          |      |         |          |                          |             |            | GOOS...                                            |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-23806 | critical | 9.10 | go      | 1.14.4   | fixed in 1.17.7, 1.16.14 | > 10 months | < 1 hour   | Curve.IsOnCurve in crypto/elliptic in Go before    |
|                |          |      |         |          | > 10 months ago          |             |            | 1.16.14 and 1.17.x before 1.17.7 can incorrectly   |
|                |          |      |         |          |                          |             |            | return true in situations with a big.Int value     |
|                |          |      |         |          |                          |             |            | that i...                                          |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-30580 | high     | 7.80 | go      | 1.14.4   | fixed in 1.18.3, 1.17.11 | > 4 months  | < 1 hour   | Code injection in Cmd.Start in os/exec before      |
|                |          |      |         |          | > 4 months ago           |             |            | Go 1.17.11 and Go 1.18.3 allows execution of any   |
|                |          |      |         |          |                          |             |            | binaries in the working directory named either     |
|                |          |      |         |          |                          |             |            | \"..com\...                                        |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-41715 | high     | 7.50 | go      | 1.14.4   | fixed in 1.19.2, 1.18.7  | 81 days     | < 1 hour   | Programs which compile regular expressions from    |
|                |          |      |         |          | 81 days ago              |             |            | untrusted sources may be vulnerable to memory      |
|                |          |      |         |          |                          |             |            | exhaustion or denial of service. The parsed regexp |
|                |          |      |         |          |                          |             |            | repre...                                           |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-3996  | high     | 7.50 | openssl | 3.0.7-r0 | fixed in 3.0.7-r2        | 21 days     | < 1 hour   | If an X.509 certificate contains a malformed       |
|                |          |      |         |          | 1 hours ago              |             |            | policy constraint and policy processing is         |
|                |          |      |         |          |                          |             |            | enabled, then a write lock will be taken twice     |
|                |          |      |         |          |                          |             |            | recursively. On...                                 |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-32189 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.5, 1.17.13 | > 4 months  | < 1 hour   | A too-short encoded message can cause a panic in   |
|                |          |      |         |          | > 4 months ago           |             |            | Float.GobDecode and Rat GobDecode in math/big in   |
|                |          |      |         |          |                          |             |            | Go before 1.17.13 and 1.18.5, potentially allowing |
|                |          |      |         |          |                          |             |            | a...                                               |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-30635 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Uncontrolled recursion in Decoder.Decode in        |
|                |          |      |         |          | > 4 months ago           |             |            | encoding/gob before Go 1.17.12 and Go 1.18.4       |
|                |          |      |         |          |                          |             |            | allows an attacker to cause a panic due to stack   |
|                |          |      |         |          |                          |             |            | exhaustion v...                                    |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-30633 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Uncontrolled recursion in Unmarshal in             |
|                |          |      |         |          | > 4 months ago           |             |            | encoding/xml before Go 1.17.12 and Go 1.18.4       |
|                |          |      |         |          |                          |             |            | allows an attacker to cause a panic due to stack   |
|                |          |      |         |          |                          |             |            | exhaustion via un...                               |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-30632 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Uncontrolled recursion in Glob in path/filepath    |
|                |          |      |         |          | > 4 months ago           |             |            | before Go 1.17.12 and Go 1.18.4 allows an attacker |
|                |          |      |         |          |                          |             |            | to cause a panic due to stack exhaustion via a     |
|                |          |      |         |          |                          |             |            | path...                                            |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-30631 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Uncontrolled recursion in Reader.Read in           |
|                |          |      |         |          | > 4 months ago           |             |            | compress/gzip before Go 1.17.12 and Go 1.18.4      |
|                |          |      |         |          |                          |             |            | allows an attacker to cause a panic due to stack   |
|                |          |      |         |          |                          |             |            | exhaustion via...                                  |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-30630 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Uncontrolled recursion in Glob in io/fs before Go  |
|                |          |      |         |          | > 4 months ago           |             |            | 1.17.12 and Go 1.18.4 allows an attacker to cause  |
|                |          |      |         |          |                          |             |            | a panic due to stack exhaustion via a path which   |
|                |          |      |         |          |                          |             |            | c...                                               |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-2880  | high     | 7.50 | go      | 1.14.4   | fixed in 1.19.2, 1.18.7  | 81 days     | < 1 hour   | Requests forwarded by ReverseProxy include the     |
|                |          |      |         |          | 81 days ago              |             |            | raw query parameters from the inbound request,     |
|                |          |      |         |          |                          |             |            | including unparseable parameters rejected by       |
|                |          |      |         |          |                          |             |            | net/http. T...                                     |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-2879  | high     | 7.50 | go      | 1.14.4   | fixed in 1.19.2, 1.18.7  | 81 days     | < 1 hour   | Reader.Read does not set a limit on the maximum    |
|                |          |      |         |          | 81 days ago              |             |            | size of file headers. A maliciously crafted        |
|                |          |      |         |          |                          |             |            | archive could cause Read to allocate unbounded     |
|                |          |      |         |          |                          |             |            | amounts of ...                                     |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-28327 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.1, 1.17.9  | > 8 months  | < 1 hour   | The generic P-256 feature in crypto/elliptic in    |
|                |          |      |         |          | > 8 months ago           |             |            | Go before 1.17.9 and 1.18.x before 1.18.1 allows a |
|                |          |      |         |          |                          |             |            | panic via long scalar input.                       |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-28131 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Uncontrolled recursion in Decoder.Skip in          |
|                |          |      |         |          | > 4 months ago           |             |            | encoding/xml before Go 1.17.12 and Go 1.18.4       |
|                |          |      |         |          |                          |             |            | allows an attacker to cause a panic due to stack   |
|                |          |      |         |          |                          |             |            | exhaustion via...                                  |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-27664 | high     | 7.50 | go      | 1.14.4   | fixed in 1.19.1, 1.18.6  | > 3 months  | < 1 hour   | In net/http in Go before 1.18.6 and 1.19.x before  |
|                |          |      |         |          | > 3 months ago           |             |            | 1.19.1, attackers can cause a denial of service    |
|                |          |      |         |          |                          |             |            | because an HTTP/2 connection can hang during       |
|                |          |      |         |          |                          |             |            | closing...                                         |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-24921 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17.8, 1.16.15 | > 10 months | < 1 hour   | regexp.Compile in Go before 1.16.15 and 1.17.x     |
|                |          |      |         |          | > 10 months ago          |             |            | before 1.17.8 allows stack exhaustion via a deeply |
|                |          |      |         |          |                          |             |            | nested expression.                                 |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-24675 | high     | 7.50 | go      | 1.14.4   | fixed in 1.18.1, 1.17.9  | > 8 months  | < 1 hour   | encoding/pem in Go before 1.17.9 and 1.18.x before |
|                |          |      |         |          | > 8 months ago           |             |            | 1.18.1 has a Decode stack overflow via a large     |
|                |          |      |         |          |                          |             |            | amount of PEM data.                                |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-23773 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17.7, 1.16.14 | > 10 months | < 1 hour   | cmd/go in Go before 1.16.14 and 1.17.x before      |
|                |          |      |         |          | > 10 months ago          |             |            | 1.17.7 can misinterpret branch names that falsely  |
|                |          |      |         |          |                          |             |            | appear to be version tags. This can lead to        |
|                |          |      |         |          |                          |             |            | incorrect ...                                      |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-23772 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17.7, 1.16.14 | > 10 months | < 1 hour   | Rat.SetString in math/big in Go before 1.16.14 and |
|                |          |      |         |          | > 10 months ago          |             |            | 1.17.x before 1.17.7 has an overflow that can lead |
|                |          |      |         |          |                          |             |            | to Uncontrolled Memory Consumption.                |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-44716 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17.5, 1.16.12 | > 1 years   | < 1 hour   | net/http in Go before 1.16.12 and 1.17.x before    |
|                |          |      |         |          | > 1 years ago            |             |            | 1.17.5 allows uncontrolled memory consumption      |
|                |          |      |         |          |                          |             |            | in the header canonicalization cache via HTTP/2    |
|                |          |      |         |          |                          |             |            | requests...                                        |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-41772 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17.3, 1.16.10 | > 1 years   | < 1 hour   | Go before 1.16.10 and 1.17.x before 1.17.3 allows  |
|                |          |      |         |          | > 1 years ago            |             |            | an archive/zip Reader.Open panic via a crafted     |
|                |          |      |         |          |                          |             |            | ZIP archive containing an invalid name or an empty |
|                |          |      |         |          |                          |             |            | fi...                                              |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-41771 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17.3, 1.16.10 | > 1 years   | < 1 hour   | ImportedSymbols in debug/macho (for Open or        |
|                |          |      |         |          | > 1 years ago            |             |            | OpenFat) in Go before 1.16.10 and 1.17.x before    |
|                |          |      |         |          |                          |             |            | 1.17.3 Accesses a Memory Location After the End of |
|                |          |      |         |          |                          |             |            | a Buffe...                                         |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-39293 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17.1, 1.16.8  | > 11 months | < 1 hour   | In archive/zip in Go before 1.16.8 and 1.17.x      |
|                |          |      |         |          | > 11 months ago          |             |            | before 1.17.1, a crafted archive header (falsely   |
|                |          |      |         |          |                          |             |            | designating that many files are present) can cause |
|                |          |      |         |          |                          |             |            | a Ne...                                            |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-33198 | high     | 7.50 | go      | 1.14.4   | fixed in 1.16.5, 1.15.13 | > 1 years   | < 1 hour   | In Go before 1.15.13 and 1.16.x before 1.16.5,     |
|                |          |      |         |          | > 1 years ago            |             |            | there can be a panic for a large exponent to the   |
|                |          |      |         |          |                          |             |            | math/big.Rat SetString or UnmarshalText method.    |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-33196 | high     | 7.50 | go      | 1.14.4   | fixed in 1.16.5, 1.15.13 | > 1 years   | < 1 hour   | In archive/zip in Go before 1.15.13 and 1.16.x     |
|                |          |      |         |          | > 1 years ago            |             |            | before 1.16.5, a crafted file count (in an         |
|                |          |      |         |          |                          |             |            | archive\'s header) can cause a NewReader or        |
|                |          |      |         |          |                          |             |            | OpenReader panic...                                |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-33194 | high     | 7.50 | go      | 1.14.4   | fixed in 1.16.5, 1.15.13 | > 1 years   | < 1 hour   | golang.org/x/net before                            |
|                |          |      |         |          | 30 days ago              |             |            | v0.0.0-20210520170846-37e1c6afe023 allows          |
|                |          |      |         |          |                          |             |            | attackers to cause a denial of service (infinite   |
|                |          |      |         |          |                          |             |            | loop) via crafted ParseFragment inp...             |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-29923 | high     | 7.50 | go      | 1.14.4   | fixed in 1.17            | > 1 years   | < 1 hour   | Go before 1.17 does not properly consider          |
|                |          |      |         |          | > 1 years ago            |             |            | extraneous zero characters at the beginning of     |
|                |          |      |         |          |                          |             |            | an IP address octet, which (in some situations)    |
|                |          |      |         |          |                          |             |            | allows attack...                                   |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-27918 | high     | 7.50 | go      | 1.14.4   | fixed in 1.16.1, 1.15.9  | > 1 years   | < 1 hour   | encoding/xml in Go before 1.15.9 and 1.16.x        |
|                |          |      |         |          | > 1 years ago            |             |            | before 1.16.1 has an infinite loop if a custom     |
|                |          |      |         |          |                          |             |            | TokenReader (for xml.NewTokenDecoder) returns EOF  |
|                |          |      |         |          |                          |             |            | in the mi...                                       |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-28367 | high     | 7.50 | go      | 1.14.4   | fixed in 1.15.5, 1.14.12 | > 2 years   | < 1 hour   | Code injection in the go command with cgo before   |
|                |          |      |         |          | > 2 years ago            |             |            | Go 1.14.12 and Go 1.15.5 allows arbitrary code     |
|                |          |      |         |          |                          |             |            | execution at build time via malicious gcc flags    |
|                |          |      |         |          |                          |             |            | specif...                                          |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-28366 | high     | 7.50 | go      | 1.14.4   | fixed in 1.15.5, 1.14.12 | > 2 years   | < 1 hour   | Code injection in the go command with cgo before   |
|                |          |      |         |          | > 2 years ago            |             |            | Go 1.14.12 and Go 1.15.5 allows arbitrary code     |
|                |          |      |         |          |                          |             |            | execution at build time via a malicious unquoted   |
|                |          |      |         |          |                          |             |            | symbo...                                           |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-28362 | high     | 7.50 | go      | 1.14.4   | fixed in 1.15.4, 1.14.12 | > 2 years   | < 1 hour   | Go before 1.14.12 and 1.15.x before 1.15.4 allows  |
|                |          |      |         |          | > 2 years ago            |             |            | Denial of Service.                                 |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-16845 | high     | 7.50 | go      | 1.14.4   | fixed in 1.14.7, 1.13.15 | > 2 years   | < 1 hour   | Go before 1.13.15 and 14.x before 1.14.7 can       |
|                |          |      |         |          | > 2 years ago            |             |            | have an infinite read loop in ReadUvarint and      |
|                |          |      |         |          |                          |             |            | ReadVarint in encoding/binary via invalid inputs.  |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-33195 | high     | 7.30 | go      | 1.14.4   | fixed in 1.16.5, 1.15.13 | > 1 years   | < 1 hour   | Go before 1.15.13 and 1.16.x before 1.16.5 has     |
|                |          |      |         |          | > 1 years ago            |             |            | functions for DNS lookups that do not validate     |
|                |          |      |         |          |                          |             |            | replies from DNS servers, and thus a return value  |
|                |          |      |         |          |                          |             |            | may co...                                          |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-32148 | medium   | 6.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Improper exposure of client IP addresses           |
|                |          |      |         |          | > 4 months ago           |             |            | in net/http before Go 1.17.12 and Go               |
|                |          |      |         |          |                          |             |            | 1.18.4 can be triggered by calling                 |
|                |          |      |         |          |                          |             |            | httputil.ReverseProxy.ServeHTTP with ...           |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-1705  | medium   | 6.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Acceptance of some invalid Transfer-Encoding       |
|                |          |      |         |          | > 4 months ago           |             |            | headers in the HTTP/1 client in net/http before    |
|                |          |      |         |          |                          |             |            | Go 1.17.12 and Go 1.18.4 allows HTTP request       |
|                |          |      |         |          |                          |             |            | smuggling if...                                    |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-34558 | medium   | 6.50 | go      | 1.14.4   | fixed in 1.16.6, 1.15.14 | > 1 years   | < 1 hour   | The crypto/tls package of Go through 1.16.5 does   |
|                |          |      |         |          | > 1 years ago            |             |            | not properly assert that the type of public key    |
|                |          |      |         |          |                          |             |            | in an X.509 certificate matches the expected type  |
|                |          |      |         |          |                          |             |            | whe...                                             |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-3114  | medium   | 6.50 | go      | 1.14.4   | fixed in 1.15.7, 1.14.14 | > 1 years   | < 1 hour   | In Go before 1.14.14 and 1.15.x before 1.15.7,     |
|                |          |      |         |          | > 1 years ago            |             |            | crypto/elliptic/p224.go can generate incorrect     |
|                |          |      |         |          |                          |             |            | outputs, related to an underflow of the lowest     |
|                |          |      |         |          |                          |             |            | limb duri...                                       |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-24553 | medium   | 6.10 | go      | 1.14.4   | fixed in 1.15.1, 1.14.8  | > 2 years   | < 1 hour   | Go before 1.14.8 and 1.15.x before 1.15.1 allows   |
|                |          |      |         |          | > 2 years ago            |             |            | XSS because text/html is the default for CGI/FCGI  |
|                |          |      |         |          |                          |             |            | handlers that lack a Content-Type header.          |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-36221 | medium   | 5.90 | go      | 1.14.4   | fixed in 1.16.7, 1.15.15 | > 1 years   | < 1 hour   | Go before 1.15.15 and 1.16.x before 1.16.7         |
|                |          |      |         |          | > 1 years ago            |             |            | has a race condition that can lead to a            |
|                |          |      |         |          |                          |             |            | net/http/httputil ReverseProxy panic upon an       |
|                |          |      |         |          |                          |             |            | ErrAbortHandler abort.                             |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-31525 | medium   | 5.90 | go      | 1.14.4   | fixed in 1.16.4, 1.15.12 | > 1 years   | < 1 hour   | net/http in Go before 1.15.12 and 1.16.x before    |
|                |          |      |         |          | > 1 years ago            |             |            | 1.16.4 allows remote attackers to cause a          |
|                |          |      |         |          |                          |             |            | denial of service (panic) via a large header to    |
|                |          |      |         |          |                          |             |            | ReadRequest ...                                    |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-15586 | medium   | 5.90 | go      | 1.14.4   | fixed in 1.14.5, 1.13.13 | > 2 years   | < 1 hour   | Go before 1.13.13 and 1.14.x before 1.14.5         |
|                |          |      |         |          | > 2 years ago            |             |            | has a data race in some net/http servers, as       |
|                |          |      |         |          |                          |             |            | demonstrated by the httputil.ReverseProxy Handler, |
|                |          |      |         |          |                          |             |            | because it ...                                     |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-29510 | medium   | 5.60 | go      | 1.14.4   | fixed in 1.15.1          | > 2 years   | < 1 hour   | The encoding/xml package in Go versions 1.15 and   |
|                |          |      |         |          | 30 days ago              |             |            | earlier does not correctly preserve the semantics  |
|                |          |      |         |          |                          |             |            | of directives during tokenization round-trips,     |
|                |          |      |         |          |                          |             |            | which...                                            |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-1962  | medium   | 5.50 | go      | 1.14.4   | fixed in 1.18.4, 1.17.12 | > 4 months  | < 1 hour   | Uncontrolled recursion in the Parse functions in   |
|                |          |      |         |          | > 4 months ago           |             |            | go/parser before Go 1.17.12 and Go 1.18.4 allow an |
|                |          |      |         |          |                          |             |            | attacker to cause a panic due to stack exhaustion  |
|                |          |      |         |          |                          |             |            | ...                                                |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-41716 | medium   | 5.40 | go      | 1.14.4   | fixed in 1.19.3, 1.18.8  | 62 days     | < 1 hour   | Due to unsanitized NUL values, attackers may be    |
|                |          |      |         |          | 61 days ago              |             |            | able to maliciously set environment variables on   |
|                |          |      |         |          |                          |             |            | Windows. In syscall.StartProcess and os/exec.Cmd,  |
|                |          |      |         |          |                          |             |            | inv...                                             |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-41717 | medium   | 5.30 | go      | 1.14.4   | fixed in 1.19.4, 1.18.9  | 26 days     | < 1 hour   | An attacker can cause excessive memory growth in a |
|                |          |      |         |          | 22 days ago              |             |            | Go server accepting HTTP/2 requests. HTTP/2 server |
|                |          |      |         |          |                          |             |            | connections contain a cache of HTTP header keys    |
|                |          |      |         |          |                          |             |            | ...                                                |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2021-33197 | medium   | 5.30 | go      | 1.14.4   | fixed in 1.16.5, 1.15.13 | > 1 years   | < 1 hour   | In Go before 1.15.13 and 1.16.x before 1.16.5,     |
|                |          |      |         |          | > 1 years ago            |             |            | some configurations of ReverseProxy (from          |
|                |          |      |         |          |                          |             |            | net/http/httputil) result in a situation where an  |
|                |          |      |         |          |                          |             |            | attacker is...                                     |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2020-14039 | medium   | 5.30 | go      | 1.14.4   | fixed in 1.14.5, 1.13.13 | > 2 years   | < 1 hour   | In Go before 1.13.13 and 1.14.x before 1.14.5,     |
|                |          |      |         |          | > 2 years ago            |             |            | Certificate.Verify may lack a check on the         |
|                |          |      |         |          |                          |             |            | VerifyOptions.KeyUsages EKU requirements (if       |
|                |          |      |         |          |                          |             |            | VerifyOptions.R...                                 |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+
| CVE-2022-30629 | low      | 3.10 | go      | 1.14.4   | fixed in 1.18.3, 1.17.11 | > 4 months  | < 1 hour   | Non-random values for ticket_age_add in session    |
|                |          |      |         |          | > 4 months ago           |             |            | tickets in crypto/tls before Go 1.17.11 and Go     |
|                |          |      |         |          |                          |             |            | 1.18.3 allow an attacker that can observe TLS      |
|                |          |      |         |          |                          |             |            | handshake...                                       |
+----------------+----------+------+---------+----------+--------------------------+-------------+------------+----------------------------------------------------+

Vulnerabilities found for image quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0: total - 49, critical - 2, high - 32, medium - 14, low - 1
Vulnerability threshold check results: PASS

Compliance Issues
+----------+------------------------------------------------+
| SEVERITY |                  DESCRIPTION                   |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| high     | Image contains binaries used for crypto mining |
+----------+------------------------------------------------+

Compliance found for image quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0: total - 9, critical - 8, high - 1, medium - 0, low - 0
Compliance threshold check results: PASS
Link to the results in Console: https://app4.prismacloud.io/compute?computeState=/monitor/vulnerabilities/images/ci?search=sha256%3A5ab315d3255b83f72c9352d901fd5610cead689f73ed792eb9a411d73a522fc4
```

Detsils from Prisma Cloud - "Compute -> Monitor -> Vulnerabilities -> Images ->
CI":

![Prisma Cloud - Image details](./img/prisma_cloud-image_details.avif)

### Wiz.io Scanner

> Files are extracted to the disk, where the scanner is running
> (local "antivirus" will detect the extracted malware files)

```bash
❯ docker pull quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
❯ wizcli docker scan --image quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
           _            _ _
 __      _(_)____   ___| (_)
 \ \ /\ / / |_  /  / __| | |
  \ V  V /| |/ /  | (__| | |
   \_/\_/ |_/___|  \___|_|_|
 SUCCESS  Ready to scan Docker image quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
 SUCCESS  Scanned Docker image
 SUCCESS  Docker image scan analysis ready
OS Package vulnerabilities:
    Name: libcrypto3, Version: 3.0.7-r0
        CVE-2022-3996, Severity: HIGH, Source: https://security.alpinelinux.org/vuln/CVE-2022-3996
            🩹 Fixed version: 3.0.7-r2
    Name: libssl3, Version: 3.0.7-r0
        CVE-2022-3996, Severity: HIGH, Source: https://security.alpinelinux.org/vuln/CVE-2022-3996
            🩹 Fixed version: 3.0.7-r2

Evaluated policy: Default vulnerabilities policy
Vulnerabilities: CRITICAL: 0, HIGH: 2, MEDIUM: 0, LOW: 0, INFORMATIONAL: 0
    Total: 2, out of which 2 are fixable
Scan results: PASSED. Container image meets policy requirements
```

Wiz details form "Reports -> CI/CD Scans":

![Wiz CICD Scans - Container image](./img/wiz-cicd_scans-container_image.avif)

Wiz details of container image running inside Amazon EKS cluster (Dashboard ->
Malware -> ...):

![Wiz - Container image running in Amazon EKS](./img/wiz-malware-cryptominer-details.avif)

### Anchore - Grype Scanner

> Files are extracted to the disk, where the scanner is running
> (local "antivirus" will detect the extracted malware files)

```bash
❯ grype --scope all-layers quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
 ✔ Vulnerability DB        [no update available]
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [34 packages]
 ✔ Scanned image           [2 vulnerabilities]
NAME        INSTALLED  FIXED-IN  TYPE  VULNERABILITY  SEVERITY
libcrypto3  3.0.7-r0             apk   CVE-2022-3996  High
libssl3     3.0.7-r0             apk   CVE-2022-3996  High
```

### Snyk Scanner

```bash
❯ docker scan quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0

Testing quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0...

Package manager:   apk
Project name:      docker-image|quay.io/petr_ruzicka/malware-cryptominer-container
Docker image:      quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
Platform:          linux/amd64
Base image:        alpine:3.17.0

✔ Tested 19 dependencies for known vulnerabilities, no vulnerable paths found.

According to our scan, you are currently using the most secure version of the selected base image

For more free scans that keep your images secure, sign up to Snyk at https://dockr.ly/3ePqVcp
```

Details form [Snyk web interface](https://snyk.io):

![Snyk - Container image](./img/snyk-container_image.avif)

### ClamAV

There is the output of the ClamAV scanner which was executed
inside container:

```bash
$ docker run -it --rm --entrypoint=/bin/sh --user root -p 8080:8080 quay.io/petr_ruzicka/malware-cryptominer-container:1.4.0
# apk add clamav
# freshclam
# clamscan --infected --recursive /usr/share/nginx/html/
/usr/share/nginx/html/Unix.Trojan.Mirai.elf.sparc: Unix.Trojan.Mirai-6976991-0 FOUND
/usr/share/nginx/html/Win.Trojan.Perl.perl: Win.Trojan.Perl-35 FOUND
/usr/share/nginx/html/xmrig/xmrig: Unix.Trojan.Generic-9919438-0 FOUND
/usr/share/nginx/html/xmrig/xmrig-linux-static-x64.tar.gz: Unix.Trojan.Generic-9919438-0 FOUND
/usr/share/nginx/html/MadMan.exe: Win.Trojan.MadMan-1 FOUND
/usr/share/nginx/html/ILOVEYOU.vbs: Win.Worm.Mantan-1 FOUND
/usr/share/nginx/html/Linux.Trojan.Multiverze.elf.x86: Unix.Trojan.Mirai-9977540-0 FOUND
/usr/share/nginx/html/Melissa.doc: Win.Trojan.Psycho-3 FOUND
/usr/share/nginx/html/WannaCry.exe: Win.Ransomware.Wannacryptor-6993233-1 FOUND
/usr/share/nginx/html/eicar/eicar.com: Win.Test.EICAR_HDB-1 FOUND
/usr/share/nginx/html/eicar/eicarcom2.zip: Win.Test.EICAR_HDB-1 FOUND
/usr/share/nginx/html/eicar/eicar.com.txt: Win.Test.EICAR_HDB-1 FOUND
/usr/share/nginx/html/Walker.com: Win.Trojan.Abraxas-7 FOUND
/usr/share/nginx/html/Unix.Trojan.Spike.elf.arm: Unix.Trojan.Spike-6301360-0 FOUND
/usr/share/nginx/html/Unix.Trojan.Mirai.elf.mips: Unix.Trojan.Mirai-6981169-0 FOUND
/usr/share/nginx/html/Unix.Trojan.Mirai.elf.m68k: Unix.Trojan.Mirai-6981989-0 FOUND
/usr/share/nginx/html/Unix.Trojan.Mirai.elf.ppc: Unix.Trojan.Mirai-6981169-0 FOUND
/usr/share/nginx/html/Unix.Malware.Kaiji.elf.arm: Unix.Malware.Kaiji-9760851-0 FOUND
/usr/share/nginx/html/Txt.Malware.Sustes.sh: Txt.Malware.Sustes-6779550-1 FOUND
/usr/share/nginx/html/Unix.Downloader.Rocke.sh: Unix.Downloader.Rocke-6826000-0 FOUND
/usr/share/nginx/html/Unix.Trojan.Mirai.elf.x86_64: Unix.Trojan.Mirai-7732430-0 FOUND
/usr/share/nginx/html/L0Lz.bat: Win.Trojan.BAT-111 FOUND
/usr/share/nginx/html/TrojanSpy.MacOS.XCSSET.A: Osx.Malware.Agent-9319628-0 FOUND
/usr/share/nginx/html/Py.Trojan.NecroBot.py: Py.Trojan.NecroBot-9868091-0 FOUND

----------- SCAN SUMMARY -----------
Known viruses: 8647075
Engine version: 0.105.1
Scanned directories: 4
Scanned files: 34
Infected files: 24
Data scanned: 25.70 MB
Data read: 18.47 MB (ratio 1.39:1)
Time: 250.429 sec (4 m 10 s)
Start Date: 2023:01:04 08:02:40
End Date:   2023:01:04 08:06:51
```

## Verify image integrity

```bash
IMAGE="quay.io/petr_ruzicka/malware-cryptominer-container:2.0.0"

cosign verify "${IMAGE}" | jq
cosign verify "${IMAGE}" | jq -r '.[].optional| .Issuer + " | " + .Subject + " | " + .githubWorkflowRef + " | https://rekor.tlog.dev/?logIndex=" + (.Bundle.Payload.logIndex|tostring)'
cosign triangulate "${IMAGE}"
cosign tree "${IMAGE}"
cosign verify-attestation --type cyclonedx "${IMAGE}" | jq '.payload |= @base64d | .payload | fromjson'
cosign verify-attestation --type slsaprovenance "${IMAGE}" | jq '.payload |= @base64d | .payload | fromjson'
```

## Local tests

Container build:

```bash
docker build . -t malware-cryptominer-container
```

Run container and download the malware file:

```bash
docker run -it --rm -p 8080:8080 malware-cryptominer-container

wget http://localhost:8080/eicar/eicar.com
```

Debug container:

```bash
docker run -it --rm --entrypoint=/bin/sh --user root -p 8080:8080 malware-cryptominer-container
```

Run in Kubernetes:

```bash
kubectl run malware-cryptominer --image=quay.io/petr_ruzicka/malware-cryptominer-container:2.0.0
```
