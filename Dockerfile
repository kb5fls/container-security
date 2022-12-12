FROM python:3.11-alpine3.16 as build

ENV XMRIG_VERSION="6.18.1"

# xmrig
RUN set -eux && \
    mkdir /mnt/xmrig && \
    wget -q "https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-linux-static-x64.tar.gz" -O /mnt/xmrig/xmrig-linux-static-x64.tar.gz && \
    tar xvzf /mnt/xmrig/xmrig-linux-static-x64.tar.gz -C /mnt/xmrig/ --strip-components=1 "xmrig-${XMRIG_VERSION}/xmrig"

# eicar
RUN set -eux && \
    mkdir /mnt/eicar && \
    wget -q -P /mnt/eicar https://secure.eicar.org/eicar.com https://secure.eicar.org/eicar.com.txt https://secure.eicar.org/eicarcom2.zip

# malware
RUN set -eux && \
    wget -q -P /mnt/ https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Virus/MadMan.exe

# ransomware
RUN set -eux && \
    wget -q -P /mnt/ https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Ransomware/WannaCry.exe

# other malware + ransomware for different architectures
RUN set -eux && \
    # ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, with debug_info, not stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Linux.Trojan.Multiverze/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5.elf.x86 -O /mnt/Linux.Trojan.Multiverze.elf.x86 && \
    # ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/40e8d9d82800728a5f1cfc2c2e156d5ee72fb44c54c26a86cfd35e95ea737e37.elf.x86_64    -O /mnt/Unix.Trojan.Mirai.elf.x86_64 && \
    # ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, Go BuildID=9fdmXJhReUX31Gj9ZEYg/ufudXOOpAambiyMItr13/otwZTTTdWsnO_OuvAAn-/qn6mMLxbKwGft_Ecoum6, stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Malware.Kaiji/3e68118ad46b9eb64063b259fca5f6682c5c2cb18fd9a4e7d97969226b2e6fb4.elf.arm      -O /mnt/Unix.Malware.Kaiji.elf.arm && \
    # ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, for GNU/Linux 2.6.16, with debug_info, not stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Spike/04d88a0f5ffa8da57cfd9b1ae6e4fd9758610a3de72688516b258b5564735476.elf.arm       -O /mnt/Unix.Trojan.Spike.elf.arm && \
    # ELF 32-bit MSB executable, MIPS, MIPS-I version 1 (SYSV), statically linked, not stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/faa0deaba42ba76192609c5d2f59664e871c7bc68ebb5d99c91bf8ea4ddb8ea5.elf.mips      -O /mnt/Unix.Trojan.Mirai.elf.mips && \
    # ELF 32-bit MSB executable, Motorola m68k, 68020, version 1 (SYSV), statically linked, stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/11242cdb5dac9309a2f330bd0dad96efba9ccc9b9d46f2361e8bf8e4cde543c1.elf.m68k      -O /mnt/Unix.Trojan.Mirai.elf.m68k && \
    # ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), statically linked, not stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/d5230c95c4af4e1fcddf9660070932b7876a9569dc3a2baedf762abbe37b1ad5.elf.ppc       -O /mnt/Unix.Trojan.Mirai.elf.ppc && \
    # ELF 32-bit MSB executable, SPARC, version 1 (SYSV), statically linked, not stripped
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Trojan.Mirai/190333b93af51f9a3e3dc4186e4f1bdb4f92c05d3ce047fbe5c3670d1b5a87b4.elf.sparc     -O /mnt/Unix.Trojan.Mirai.elf.sparc && \
    # POSIX shell script, ASCII text executable
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Unix.Downloader.Rocke/228ec858509a928b21e88d582cb5cfaabc03f72d30f2179ef6fb232b6abdce97.sh        -O /mnt/Unix.Downloader.Rocke.sh && \
    # Bourne-Again shell script, ASCII text executable
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Txt.Malware.Sustes/0e77291955664d2c25d5bfe617cec12a388e5389f82dee5ae4fd5c5d1f1bdefe.sh           -O /mnt/Txt.Malware.Sustes.sh && \
    # Perl script text executable
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Win.Trojan.Perl/9aed7ab8806a90aa9fac070fbf788466c6da3d87deba92a25ac4dd1d63ce4c44.perl            -O /mnt/Win.Trojan.Perl.perl && \
    # Python script, ASCII text executable, with very long lines (4330), with CRLF line terminators
    wget -q https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Py.Trojan.NecroBot/0e600095a3c955310d27c08f98a012720caff698fe24303d7e0dcb4c5e766322.py           -O /mnt/Py.Trojan.NecroBot.py

COPY img /mnt/img
COPY README.md /mnt/

RUN set -eux && \
    pip install --no-cache-dir grip==4.6.1 && \
    grip /mnt/README.md --export /mnt/index.html

####

FROM nginxinc/nginx-unprivileged:1.23-alpine-slim

COPY --from=build /mnt/ /usr/share/nginx/html/

RUN printf '%s\n' > /etc/nginx/conf.d/health.conf \
    'server {' \
    '    listen 8081;' \
    '    location / {' \
    '        access_log off;' \
    '        add_header Content-Type text/plain;' \
    '        return 200 "healthy\n";' \
    '    }' \
    '}'

USER nginx

#Healthcheck to make sure container is ready
HEALTHCHECK --interval=5m --timeout=3s CMD curl --fail http://localhost:8081 || exit 1
