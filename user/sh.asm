
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
    }
    exit(0);
}

int getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
    write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	7ce58593          	addi	a1,a1,1998 # 17e0 <malloc+0xf2>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	2ba080e7          	jalr	698(ra) # 12d6 <write>
    memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	092080e7          	jalr	146(ra) # 10bc <memset>
    gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	0cc080e7          	jalr	204(ra) # 1102 <gets>
    if (buf[0] == 0) // EOF
      3e:	0004c503          	lbu	a0,0(s1)
      42:	00153513          	seqz	a0,a0
        return -1;
    return 0;
}
      46:	40a00533          	neg	a0,a0
      4a:	60e2                	ld	ra,24(sp)
      4c:	6442                	ld	s0,16(sp)
      4e:	64a2                	ld	s1,8(sp)
      50:	6902                	ld	s2,0(sp)
      52:	6105                	addi	sp,sp,32
      54:	8082                	ret

0000000000000056 <panic>:
    }
    exit(0);
}

void panic(char *s)
{
      56:	1141                	addi	sp,sp,-16
      58:	e406                	sd	ra,8(sp)
      5a:	e022                	sd	s0,0(sp)
      5c:	0800                	addi	s0,sp,16
      5e:	862a                	mv	a2,a0
    fprintf(2, "%s\n", s);
      60:	00001597          	auipc	a1,0x1
      64:	78858593          	addi	a1,a1,1928 # 17e8 <malloc+0xfa>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	59e080e7          	jalr	1438(ra) # 1608 <fprintf>
    exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	242080e7          	jalr	578(ra) # 12b6 <exit>

000000000000007c <fork1>:
}

int fork1(void)
{
      7c:	1141                	addi	sp,sp,-16
      7e:	e406                	sd	ra,8(sp)
      80:	e022                	sd	s0,0(sp)
      82:	0800                	addi	s0,sp,16
    int pid;

    pid = fork();
      84:	00001097          	auipc	ra,0x1
      88:	22a080e7          	jalr	554(ra) # 12ae <fork>
    if (pid == -1)
      8c:	57fd                	li	a5,-1
      8e:	00f50663          	beq	a0,a5,9a <fork1+0x1e>
        panic("fork");
    return pid;
}
      92:	60a2                	ld	ra,8(sp)
      94:	6402                	ld	s0,0(sp)
      96:	0141                	addi	sp,sp,16
      98:	8082                	ret
        panic("fork");
      9a:	00001517          	auipc	a0,0x1
      9e:	75650513          	addi	a0,a0,1878 # 17f0 <malloc+0x102>
      a2:	00000097          	auipc	ra,0x0
      a6:	fb4080e7          	jalr	-76(ra) # 56 <panic>

00000000000000aa <runcmd>:
{
      aa:	7179                	addi	sp,sp,-48
      ac:	f406                	sd	ra,40(sp)
      ae:	f022                	sd	s0,32(sp)
      b0:	ec26                	sd	s1,24(sp)
      b2:	1800                	addi	s0,sp,48
    if (cmd == 0)
      b4:	c10d                	beqz	a0,d6 <runcmd+0x2c>
      b6:	84aa                	mv	s1,a0
    switch (cmd->type)
      b8:	4118                	lw	a4,0(a0)
      ba:	4795                	li	a5,5
      bc:	02e7e263          	bltu	a5,a4,e0 <runcmd+0x36>
      c0:	00056783          	lwu	a5,0(a0)
      c4:	078a                	slli	a5,a5,0x2
      c6:	00002717          	auipc	a4,0x2
      ca:	83e70713          	addi	a4,a4,-1986 # 1904 <malloc+0x216>
      ce:	97ba                	add	a5,a5,a4
      d0:	439c                	lw	a5,0(a5)
      d2:	97ba                	add	a5,a5,a4
      d4:	8782                	jr	a5
        exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	1de080e7          	jalr	478(ra) # 12b6 <exit>
        panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	71850513          	addi	a0,a0,1816 # 17f8 <malloc+0x10a>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6e080e7          	jalr	-146(ra) # 56 <panic>
        if (ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x74>
        exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	addi	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	1f6080e7          	jalr	502(ra) # 12ee <exec>
        fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	6fe58593          	addi	a1,a1,1790 # 1800 <malloc+0x112>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	4fc080e7          	jalr	1276(ra) # 1608 <fprintf>
    exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	1a0080e7          	jalr	416(ra) # 12b6 <exit>
            exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	196080e7          	jalr	406(ra) # 12b6 <exit>
        close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	1b4080e7          	jalr	436(ra) # 12de <close>
        if (open(rcmd->file, rcmd->mode) < 0)
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	1c0080e7          	jalr	448(ra) # 12f6 <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa2>
        runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f66080e7          	jalr	-154(ra) # aa <runcmd>
            fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	6c258593          	addi	a1,a1,1730 # 1810 <malloc+0x122>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	4b0080e7          	jalr	1200(ra) # 1608 <fprintf>
            exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	154080e7          	jalr	340(ra) # 12b6 <exit>
        if (fork1() == 0)
     16a:	00000097          	auipc	ra,0x0
     16e:	f12080e7          	jalr	-238(ra) # 7c <fork1>
     172:	e511                	bnez	a0,17e <runcmd+0xd4>
            runcmd(lcmd->left);
     174:	6488                	ld	a0,8(s1)
     176:	00000097          	auipc	ra,0x0
     17a:	f34080e7          	jalr	-204(ra) # aa <runcmd>
        wait(0);
     17e:	4501                	li	a0,0
     180:	00001097          	auipc	ra,0x1
     184:	13e080e7          	jalr	318(ra) # 12be <wait>
        runcmd(lcmd->right);
     188:	6888                	ld	a0,16(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f20080e7          	jalr	-224(ra) # aa <runcmd>
        if (pipe(p) < 0)
     192:	fd840513          	addi	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	130080e7          	jalr	304(ra) # 12c6 <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13a>
        if (fork1() == 0)
     1a2:	00000097          	auipc	ra,0x0
     1a6:	eda080e7          	jalr	-294(ra) # 7c <fork1>
     1aa:	e529                	bnez	a0,1f4 <runcmd+0x14a>
            close(1);
     1ac:	4505                	li	a0,1
     1ae:	00001097          	auipc	ra,0x1
     1b2:	130080e7          	jalr	304(ra) # 12de <close>
            dup(p[1]);
     1b6:	fdc42503          	lw	a0,-36(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	174080e7          	jalr	372(ra) # 132e <dup>
            close(p[0]);
     1c2:	fd842503          	lw	a0,-40(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	118080e7          	jalr	280(ra) # 12de <close>
            close(p[1]);
     1ce:	fdc42503          	lw	a0,-36(s0)
     1d2:	00001097          	auipc	ra,0x1
     1d6:	10c080e7          	jalr	268(ra) # 12de <close>
            runcmd(pcmd->left);
     1da:	6488                	ld	a0,8(s1)
     1dc:	00000097          	auipc	ra,0x0
     1e0:	ece080e7          	jalr	-306(ra) # aa <runcmd>
            panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	63c50513          	addi	a0,a0,1596 # 1820 <malloc+0x132>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e6a080e7          	jalr	-406(ra) # 56 <panic>
        if (fork1() == 0)
     1f4:	00000097          	auipc	ra,0x0
     1f8:	e88080e7          	jalr	-376(ra) # 7c <fork1>
     1fc:	ed05                	bnez	a0,234 <runcmd+0x18a>
            close(0);
     1fe:	00001097          	auipc	ra,0x1
     202:	0e0080e7          	jalr	224(ra) # 12de <close>
            dup(p[0]);
     206:	fd842503          	lw	a0,-40(s0)
     20a:	00001097          	auipc	ra,0x1
     20e:	124080e7          	jalr	292(ra) # 132e <dup>
            close(p[0]);
     212:	fd842503          	lw	a0,-40(s0)
     216:	00001097          	auipc	ra,0x1
     21a:	0c8080e7          	jalr	200(ra) # 12de <close>
            close(p[1]);
     21e:	fdc42503          	lw	a0,-36(s0)
     222:	00001097          	auipc	ra,0x1
     226:	0bc080e7          	jalr	188(ra) # 12de <close>
            runcmd(pcmd->right);
     22a:	6888                	ld	a0,16(s1)
     22c:	00000097          	auipc	ra,0x0
     230:	e7e080e7          	jalr	-386(ra) # aa <runcmd>
        close(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	0a6080e7          	jalr	166(ra) # 12de <close>
        close(p[1]);
     240:	fdc42503          	lw	a0,-36(s0)
     244:	00001097          	auipc	ra,0x1
     248:	09a080e7          	jalr	154(ra) # 12de <close>
        wait(0);
     24c:	4501                	li	a0,0
     24e:	00001097          	auipc	ra,0x1
     252:	070080e7          	jalr	112(ra) # 12be <wait>
        wait(0);
     256:	4501                	li	a0,0
     258:	00001097          	auipc	ra,0x1
     25c:	066080e7          	jalr	102(ra) # 12be <wait>
        break;
     260:	bd55                	j	114 <runcmd+0x6a>
        if (fork1() == 0)
     262:	00000097          	auipc	ra,0x0
     266:	e1a080e7          	jalr	-486(ra) # 7c <fork1>
     26a:	ea0515e3          	bnez	a0,114 <runcmd+0x6a>
            runcmd(bcmd->cmd);
     26e:	6488                	ld	a0,8(s1)
     270:	00000097          	auipc	ra,0x0
     274:	e3a080e7          	jalr	-454(ra) # aa <runcmd>

0000000000000278 <execcmd>:
// PAGEBREAK!
//  Constructors

struct cmd *
execcmd(void)
{
     278:	1101                	addi	sp,sp,-32
     27a:	ec06                	sd	ra,24(sp)
     27c:	e822                	sd	s0,16(sp)
     27e:	e426                	sd	s1,8(sp)
     280:	1000                	addi	s0,sp,32
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     282:	0a800513          	li	a0,168
     286:	00001097          	auipc	ra,0x1
     28a:	468080e7          	jalr	1128(ra) # 16ee <malloc>
     28e:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	e26080e7          	jalr	-474(ra) # 10bc <memset>
    cmd->type = EXEC;
     29e:	4785                	li	a5,1
     2a0:	c09c                	sw	a5,0(s1)
    return (struct cmd *)cmd;
}
     2a2:	8526                	mv	a0,s1
     2a4:	60e2                	ld	ra,24(sp)
     2a6:	6442                	ld	s0,16(sp)
     2a8:	64a2                	ld	s1,8(sp)
     2aa:	6105                	addi	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <redircmd>:

struct cmd *
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2ae:	7139                	addi	sp,sp,-64
     2b0:	fc06                	sd	ra,56(sp)
     2b2:	f822                	sd	s0,48(sp)
     2b4:	f426                	sd	s1,40(sp)
     2b6:	f04a                	sd	s2,32(sp)
     2b8:	ec4e                	sd	s3,24(sp)
     2ba:	e852                	sd	s4,16(sp)
     2bc:	e456                	sd	s5,8(sp)
     2be:	e05a                	sd	s6,0(sp)
     2c0:	0080                	addi	s0,sp,64
     2c2:	8b2a                	mv	s6,a0
     2c4:	8aae                	mv	s5,a1
     2c6:	8a32                	mv	s4,a2
     2c8:	89b6                	mv	s3,a3
     2ca:	893a                	mv	s2,a4
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     2cc:	02800513          	li	a0,40
     2d0:	00001097          	auipc	ra,0x1
     2d4:	41e080e7          	jalr	1054(ra) # 16ee <malloc>
     2d8:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	ddc080e7          	jalr	-548(ra) # 10bc <memset>
    cmd->type = REDIR;
     2e8:	4789                	li	a5,2
     2ea:	c09c                	sw	a5,0(s1)
    cmd->cmd = subcmd;
     2ec:	0164b423          	sd	s6,8(s1)
    cmd->file = file;
     2f0:	0154b823          	sd	s5,16(s1)
    cmd->efile = efile;
     2f4:	0144bc23          	sd	s4,24(s1)
    cmd->mode = mode;
     2f8:	0334a023          	sw	s3,32(s1)
    cmd->fd = fd;
     2fc:	0324a223          	sw	s2,36(s1)
    return (struct cmd *)cmd;
}
     300:	8526                	mv	a0,s1
     302:	70e2                	ld	ra,56(sp)
     304:	7442                	ld	s0,48(sp)
     306:	74a2                	ld	s1,40(sp)
     308:	7902                	ld	s2,32(sp)
     30a:	69e2                	ld	s3,24(sp)
     30c:	6a42                	ld	s4,16(sp)
     30e:	6aa2                	ld	s5,8(sp)
     310:	6b02                	ld	s6,0(sp)
     312:	6121                	addi	sp,sp,64
     314:	8082                	ret

0000000000000316 <pipecmd>:

struct cmd *
pipecmd(struct cmd *left, struct cmd *right)
{
     316:	7179                	addi	sp,sp,-48
     318:	f406                	sd	ra,40(sp)
     31a:	f022                	sd	s0,32(sp)
     31c:	ec26                	sd	s1,24(sp)
     31e:	e84a                	sd	s2,16(sp)
     320:	e44e                	sd	s3,8(sp)
     322:	1800                	addi	s0,sp,48
     324:	89aa                	mv	s3,a0
     326:	892e                	mv	s2,a1
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     328:	4561                	li	a0,24
     32a:	00001097          	auipc	ra,0x1
     32e:	3c4080e7          	jalr	964(ra) # 16ee <malloc>
     332:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	d84080e7          	jalr	-636(ra) # 10bc <memset>
    cmd->type = PIPE;
     340:	478d                	li	a5,3
     342:	c09c                	sw	a5,0(s1)
    cmd->left = left;
     344:	0134b423          	sd	s3,8(s1)
    cmd->right = right;
     348:	0124b823          	sd	s2,16(s1)
    return (struct cmd *)cmd;
}
     34c:	8526                	mv	a0,s1
     34e:	70a2                	ld	ra,40(sp)
     350:	7402                	ld	s0,32(sp)
     352:	64e2                	ld	s1,24(sp)
     354:	6942                	ld	s2,16(sp)
     356:	69a2                	ld	s3,8(sp)
     358:	6145                	addi	sp,sp,48
     35a:	8082                	ret

000000000000035c <listcmd>:

struct cmd *
listcmd(struct cmd *left, struct cmd *right)
{
     35c:	7179                	addi	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	ec26                	sd	s1,24(sp)
     364:	e84a                	sd	s2,16(sp)
     366:	e44e                	sd	s3,8(sp)
     368:	1800                	addi	s0,sp,48
     36a:	89aa                	mv	s3,a0
     36c:	892e                	mv	s2,a1
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     36e:	4561                	li	a0,24
     370:	00001097          	auipc	ra,0x1
     374:	37e080e7          	jalr	894(ra) # 16ee <malloc>
     378:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	d3e080e7          	jalr	-706(ra) # 10bc <memset>
    cmd->type = LIST;
     386:	4791                	li	a5,4
     388:	c09c                	sw	a5,0(s1)
    cmd->left = left;
     38a:	0134b423          	sd	s3,8(s1)
    cmd->right = right;
     38e:	0124b823          	sd	s2,16(s1)
    return (struct cmd *)cmd;
}
     392:	8526                	mv	a0,s1
     394:	70a2                	ld	ra,40(sp)
     396:	7402                	ld	s0,32(sp)
     398:	64e2                	ld	s1,24(sp)
     39a:	6942                	ld	s2,16(sp)
     39c:	69a2                	ld	s3,8(sp)
     39e:	6145                	addi	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <backcmd>:

struct cmd *
backcmd(struct cmd *subcmd)
{
     3a2:	1101                	addi	sp,sp,-32
     3a4:	ec06                	sd	ra,24(sp)
     3a6:	e822                	sd	s0,16(sp)
     3a8:	e426                	sd	s1,8(sp)
     3aa:	e04a                	sd	s2,0(sp)
     3ac:	1000                	addi	s0,sp,32
     3ae:	892a                	mv	s2,a0
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     3b0:	4541                	li	a0,16
     3b2:	00001097          	auipc	ra,0x1
     3b6:	33c080e7          	jalr	828(ra) # 16ee <malloc>
     3ba:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	cfc080e7          	jalr	-772(ra) # 10bc <memset>
    cmd->type = BACK;
     3c8:	4795                	li	a5,5
     3ca:	c09c                	sw	a5,0(s1)
    cmd->cmd = subcmd;
     3cc:	0124b423          	sd	s2,8(s1)
    return (struct cmd *)cmd;
}
     3d0:	8526                	mv	a0,s1
     3d2:	60e2                	ld	ra,24(sp)
     3d4:	6442                	ld	s0,16(sp)
     3d6:	64a2                	ld	s1,8(sp)
     3d8:	6902                	ld	s2,0(sp)
     3da:	6105                	addi	sp,sp,32
     3dc:	8082                	ret

00000000000003de <gettoken>:

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int gettoken(char **ps, char *es, char **q, char **eq)
{
     3de:	7139                	addi	sp,sp,-64
     3e0:	fc06                	sd	ra,56(sp)
     3e2:	f822                	sd	s0,48(sp)
     3e4:	f426                	sd	s1,40(sp)
     3e6:	f04a                	sd	s2,32(sp)
     3e8:	ec4e                	sd	s3,24(sp)
     3ea:	e852                	sd	s4,16(sp)
     3ec:	e456                	sd	s5,8(sp)
     3ee:	e05a                	sd	s6,0(sp)
     3f0:	0080                	addi	s0,sp,64
     3f2:	8a2a                	mv	s4,a0
     3f4:	892e                	mv	s2,a1
     3f6:	8ab2                	mv	s5,a2
     3f8:	8b36                	mv	s6,a3
    char *s;
    int ret;

    s = *ps;
     3fa:	6104                	ld	s1,0(a0)
    while (s < es && strchr(whitespace, *s))
     3fc:	00002997          	auipc	s3,0x2
     400:	c0c98993          	addi	s3,s3,-1012 # 2008 <whitespace>
     404:	00b4fe63          	bgeu	s1,a1,420 <gettoken+0x42>
     408:	0004c583          	lbu	a1,0(s1)
     40c:	854e                	mv	a0,s3
     40e:	00001097          	auipc	ra,0x1
     412:	cd0080e7          	jalr	-816(ra) # 10de <strchr>
     416:	c509                	beqz	a0,420 <gettoken+0x42>
        s++;
     418:	0485                	addi	s1,s1,1
    while (s < es && strchr(whitespace, *s))
     41a:	fe9917e3          	bne	s2,s1,408 <gettoken+0x2a>
        s++;
     41e:	84ca                	mv	s1,s2
    if (q)
     420:	000a8463          	beqz	s5,428 <gettoken+0x4a>
        *q = s;
     424:	009ab023          	sd	s1,0(s5)
    ret = *s;
     428:	0004c783          	lbu	a5,0(s1)
     42c:	00078a9b          	sext.w	s5,a5
    switch (*s)
     430:	03c00713          	li	a4,60
     434:	06f76663          	bltu	a4,a5,4a0 <gettoken+0xc2>
     438:	03a00713          	li	a4,58
     43c:	00f76e63          	bltu	a4,a5,458 <gettoken+0x7a>
     440:	cf89                	beqz	a5,45a <gettoken+0x7c>
     442:	02600713          	li	a4,38
     446:	00e78963          	beq	a5,a4,458 <gettoken+0x7a>
     44a:	fd87879b          	addiw	a5,a5,-40
     44e:	0ff7f793          	zext.b	a5,a5
     452:	4705                	li	a4,1
     454:	06f76d63          	bltu	a4,a5,4ce <gettoken+0xf0>
    case '(':
    case ')':
    case ';':
    case '&':
    case '<':
        s++;
     458:	0485                	addi	s1,s1,1
        ret = 'a';
        while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
            s++;
        break;
    }
    if (eq)
     45a:	000b0463          	beqz	s6,462 <gettoken+0x84>
        *eq = s;
     45e:	009b3023          	sd	s1,0(s6)

    while (s < es && strchr(whitespace, *s))
     462:	00002997          	auipc	s3,0x2
     466:	ba698993          	addi	s3,s3,-1114 # 2008 <whitespace>
     46a:	0124fe63          	bgeu	s1,s2,486 <gettoken+0xa8>
     46e:	0004c583          	lbu	a1,0(s1)
     472:	854e                	mv	a0,s3
     474:	00001097          	auipc	ra,0x1
     478:	c6a080e7          	jalr	-918(ra) # 10de <strchr>
     47c:	c509                	beqz	a0,486 <gettoken+0xa8>
        s++;
     47e:	0485                	addi	s1,s1,1
    while (s < es && strchr(whitespace, *s))
     480:	fe9917e3          	bne	s2,s1,46e <gettoken+0x90>
        s++;
     484:	84ca                	mv	s1,s2
    *ps = s;
     486:	009a3023          	sd	s1,0(s4)
    return ret;
}
     48a:	8556                	mv	a0,s5
     48c:	70e2                	ld	ra,56(sp)
     48e:	7442                	ld	s0,48(sp)
     490:	74a2                	ld	s1,40(sp)
     492:	7902                	ld	s2,32(sp)
     494:	69e2                	ld	s3,24(sp)
     496:	6a42                	ld	s4,16(sp)
     498:	6aa2                	ld	s5,8(sp)
     49a:	6b02                	ld	s6,0(sp)
     49c:	6121                	addi	sp,sp,64
     49e:	8082                	ret
    switch (*s)
     4a0:	03e00713          	li	a4,62
     4a4:	02e79163          	bne	a5,a4,4c6 <gettoken+0xe8>
        s++;
     4a8:	00148693          	addi	a3,s1,1
        if (*s == '>')
     4ac:	0014c703          	lbu	a4,1(s1)
     4b0:	03e00793          	li	a5,62
            s++;
     4b4:	0489                	addi	s1,s1,2
            ret = '+';
     4b6:	02b00a93          	li	s5,43
        if (*s == '>')
     4ba:	faf700e3          	beq	a4,a5,45a <gettoken+0x7c>
        s++;
     4be:	84b6                	mv	s1,a3
    ret = *s;
     4c0:	03e00a93          	li	s5,62
     4c4:	bf59                	j	45a <gettoken+0x7c>
    switch (*s)
     4c6:	07c00713          	li	a4,124
     4ca:	f8e787e3          	beq	a5,a4,458 <gettoken+0x7a>
        while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4ce:	00002997          	auipc	s3,0x2
     4d2:	b3a98993          	addi	s3,s3,-1222 # 2008 <whitespace>
     4d6:	00002a97          	auipc	s5,0x2
     4da:	b2aa8a93          	addi	s5,s5,-1238 # 2000 <symbols>
     4de:	0524f163          	bgeu	s1,s2,520 <gettoken+0x142>
     4e2:	0004c583          	lbu	a1,0(s1)
     4e6:	854e                	mv	a0,s3
     4e8:	00001097          	auipc	ra,0x1
     4ec:	bf6080e7          	jalr	-1034(ra) # 10de <strchr>
     4f0:	e50d                	bnez	a0,51a <gettoken+0x13c>
     4f2:	0004c583          	lbu	a1,0(s1)
     4f6:	8556                	mv	a0,s5
     4f8:	00001097          	auipc	ra,0x1
     4fc:	be6080e7          	jalr	-1050(ra) # 10de <strchr>
     500:	e911                	bnez	a0,514 <gettoken+0x136>
            s++;
     502:	0485                	addi	s1,s1,1
        while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     504:	fc991fe3          	bne	s2,s1,4e2 <gettoken+0x104>
            s++;
     508:	84ca                	mv	s1,s2
        ret = 'a';
     50a:	06100a93          	li	s5,97
    if (eq)
     50e:	f40b18e3          	bnez	s6,45e <gettoken+0x80>
     512:	bf95                	j	486 <gettoken+0xa8>
        ret = 'a';
     514:	06100a93          	li	s5,97
     518:	b789                	j	45a <gettoken+0x7c>
     51a:	06100a93          	li	s5,97
     51e:	bf35                	j	45a <gettoken+0x7c>
     520:	06100a93          	li	s5,97
    if (eq)
     524:	f20b1de3          	bnez	s6,45e <gettoken+0x80>
     528:	bfb9                	j	486 <gettoken+0xa8>

000000000000052a <peek>:

int peek(char **ps, char *es, char *toks)
{
     52a:	7139                	addi	sp,sp,-64
     52c:	fc06                	sd	ra,56(sp)
     52e:	f822                	sd	s0,48(sp)
     530:	f426                	sd	s1,40(sp)
     532:	f04a                	sd	s2,32(sp)
     534:	ec4e                	sd	s3,24(sp)
     536:	e852                	sd	s4,16(sp)
     538:	e456                	sd	s5,8(sp)
     53a:	0080                	addi	s0,sp,64
     53c:	8a2a                	mv	s4,a0
     53e:	892e                	mv	s2,a1
     540:	8ab2                	mv	s5,a2
    char *s;

    s = *ps;
     542:	6104                	ld	s1,0(a0)
    while (s < es && strchr(whitespace, *s))
     544:	00002997          	auipc	s3,0x2
     548:	ac498993          	addi	s3,s3,-1340 # 2008 <whitespace>
     54c:	00b4fe63          	bgeu	s1,a1,568 <peek+0x3e>
     550:	0004c583          	lbu	a1,0(s1)
     554:	854e                	mv	a0,s3
     556:	00001097          	auipc	ra,0x1
     55a:	b88080e7          	jalr	-1144(ra) # 10de <strchr>
     55e:	c509                	beqz	a0,568 <peek+0x3e>
        s++;
     560:	0485                	addi	s1,s1,1
    while (s < es && strchr(whitespace, *s))
     562:	fe9917e3          	bne	s2,s1,550 <peek+0x26>
        s++;
     566:	84ca                	mv	s1,s2
    *ps = s;
     568:	009a3023          	sd	s1,0(s4)
    return *s && strchr(toks, *s);
     56c:	0004c583          	lbu	a1,0(s1)
     570:	4501                	li	a0,0
     572:	e991                	bnez	a1,586 <peek+0x5c>
}
     574:	70e2                	ld	ra,56(sp)
     576:	7442                	ld	s0,48(sp)
     578:	74a2                	ld	s1,40(sp)
     57a:	7902                	ld	s2,32(sp)
     57c:	69e2                	ld	s3,24(sp)
     57e:	6a42                	ld	s4,16(sp)
     580:	6aa2                	ld	s5,8(sp)
     582:	6121                	addi	sp,sp,64
     584:	8082                	ret
    return *s && strchr(toks, *s);
     586:	8556                	mv	a0,s5
     588:	00001097          	auipc	ra,0x1
     58c:	b56080e7          	jalr	-1194(ra) # 10de <strchr>
     590:	00a03533          	snez	a0,a0
     594:	b7c5                	j	574 <peek+0x4a>

0000000000000596 <parseredirs>:
    return cmd;
}

struct cmd *
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     596:	7159                	addi	sp,sp,-112
     598:	f486                	sd	ra,104(sp)
     59a:	f0a2                	sd	s0,96(sp)
     59c:	eca6                	sd	s1,88(sp)
     59e:	e8ca                	sd	s2,80(sp)
     5a0:	e4ce                	sd	s3,72(sp)
     5a2:	e0d2                	sd	s4,64(sp)
     5a4:	fc56                	sd	s5,56(sp)
     5a6:	f85a                	sd	s6,48(sp)
     5a8:	f45e                	sd	s7,40(sp)
     5aa:	f062                	sd	s8,32(sp)
     5ac:	ec66                	sd	s9,24(sp)
     5ae:	1880                	addi	s0,sp,112
     5b0:	8a2a                	mv	s4,a0
     5b2:	89ae                	mv	s3,a1
     5b4:	8932                	mv	s2,a2
    int tok;
    char *q, *eq;

    while (peek(ps, es, "<>"))
     5b6:	00001b97          	auipc	s7,0x1
     5ba:	292b8b93          	addi	s7,s7,658 # 1848 <malloc+0x15a>
    {
        tok = gettoken(ps, es, 0, 0);
        if (gettoken(ps, es, &q, &eq) != 'a')
     5be:	06100c13          	li	s8,97
            panic("missing file for redirection");
        switch (tok)
     5c2:	03c00c93          	li	s9,60
    while (peek(ps, es, "<>"))
     5c6:	a02d                	j	5f0 <parseredirs+0x5a>
            panic("missing file for redirection");
     5c8:	00001517          	auipc	a0,0x1
     5cc:	26050513          	addi	a0,a0,608 # 1828 <malloc+0x13a>
     5d0:	00000097          	auipc	ra,0x0
     5d4:	a86080e7          	jalr	-1402(ra) # 56 <panic>
        {
        case '<':
            cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5d8:	4701                	li	a4,0
     5da:	4681                	li	a3,0
     5dc:	f9043603          	ld	a2,-112(s0)
     5e0:	f9843583          	ld	a1,-104(s0)
     5e4:	8552                	mv	a0,s4
     5e6:	00000097          	auipc	ra,0x0
     5ea:	cc8080e7          	jalr	-824(ra) # 2ae <redircmd>
     5ee:	8a2a                	mv	s4,a0
        switch (tok)
     5f0:	03e00b13          	li	s6,62
     5f4:	02b00a93          	li	s5,43
    while (peek(ps, es, "<>"))
     5f8:	865e                	mv	a2,s7
     5fa:	85ca                	mv	a1,s2
     5fc:	854e                	mv	a0,s3
     5fe:	00000097          	auipc	ra,0x0
     602:	f2c080e7          	jalr	-212(ra) # 52a <peek>
     606:	c925                	beqz	a0,676 <parseredirs+0xe0>
        tok = gettoken(ps, es, 0, 0);
     608:	4681                	li	a3,0
     60a:	4601                	li	a2,0
     60c:	85ca                	mv	a1,s2
     60e:	854e                	mv	a0,s3
     610:	00000097          	auipc	ra,0x0
     614:	dce080e7          	jalr	-562(ra) # 3de <gettoken>
     618:	84aa                	mv	s1,a0
        if (gettoken(ps, es, &q, &eq) != 'a')
     61a:	f9040693          	addi	a3,s0,-112
     61e:	f9840613          	addi	a2,s0,-104
     622:	85ca                	mv	a1,s2
     624:	854e                	mv	a0,s3
     626:	00000097          	auipc	ra,0x0
     62a:	db8080e7          	jalr	-584(ra) # 3de <gettoken>
     62e:	f9851de3          	bne	a0,s8,5c8 <parseredirs+0x32>
        switch (tok)
     632:	fb9483e3          	beq	s1,s9,5d8 <parseredirs+0x42>
     636:	03648263          	beq	s1,s6,65a <parseredirs+0xc4>
     63a:	fb549fe3          	bne	s1,s5,5f8 <parseredirs+0x62>
            break;
        case '>':
            cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
            break;
        case '+': // >>
            cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE, 1);
     63e:	4705                	li	a4,1
     640:	20100693          	li	a3,513
     644:	f9043603          	ld	a2,-112(s0)
     648:	f9843583          	ld	a1,-104(s0)
     64c:	8552                	mv	a0,s4
     64e:	00000097          	auipc	ra,0x0
     652:	c60080e7          	jalr	-928(ra) # 2ae <redircmd>
     656:	8a2a                	mv	s4,a0
            break;
     658:	bf61                	j	5f0 <parseredirs+0x5a>
            cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
     65a:	4705                	li	a4,1
     65c:	60100693          	li	a3,1537
     660:	f9043603          	ld	a2,-112(s0)
     664:	f9843583          	ld	a1,-104(s0)
     668:	8552                	mv	a0,s4
     66a:	00000097          	auipc	ra,0x0
     66e:	c44080e7          	jalr	-956(ra) # 2ae <redircmd>
     672:	8a2a                	mv	s4,a0
            break;
     674:	bfb5                	j	5f0 <parseredirs+0x5a>
        }
    }
    return cmd;
}
     676:	8552                	mv	a0,s4
     678:	70a6                	ld	ra,104(sp)
     67a:	7406                	ld	s0,96(sp)
     67c:	64e6                	ld	s1,88(sp)
     67e:	6946                	ld	s2,80(sp)
     680:	69a6                	ld	s3,72(sp)
     682:	6a06                	ld	s4,64(sp)
     684:	7ae2                	ld	s5,56(sp)
     686:	7b42                	ld	s6,48(sp)
     688:	7ba2                	ld	s7,40(sp)
     68a:	7c02                	ld	s8,32(sp)
     68c:	6ce2                	ld	s9,24(sp)
     68e:	6165                	addi	sp,sp,112
     690:	8082                	ret

0000000000000692 <parseexec>:
    return cmd;
}

struct cmd *
parseexec(char **ps, char *es)
{
     692:	7159                	addi	sp,sp,-112
     694:	f486                	sd	ra,104(sp)
     696:	f0a2                	sd	s0,96(sp)
     698:	eca6                	sd	s1,88(sp)
     69a:	e8ca                	sd	s2,80(sp)
     69c:	e4ce                	sd	s3,72(sp)
     69e:	e0d2                	sd	s4,64(sp)
     6a0:	fc56                	sd	s5,56(sp)
     6a2:	f85a                	sd	s6,48(sp)
     6a4:	f45e                	sd	s7,40(sp)
     6a6:	f062                	sd	s8,32(sp)
     6a8:	ec66                	sd	s9,24(sp)
     6aa:	1880                	addi	s0,sp,112
     6ac:	8a2a                	mv	s4,a0
     6ae:	8aae                	mv	s5,a1
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if (peek(ps, es, "("))
     6b0:	00001617          	auipc	a2,0x1
     6b4:	1a060613          	addi	a2,a2,416 # 1850 <malloc+0x162>
     6b8:	00000097          	auipc	ra,0x0
     6bc:	e72080e7          	jalr	-398(ra) # 52a <peek>
     6c0:	e905                	bnez	a0,6f0 <parseexec+0x5e>
     6c2:	89aa                	mv	s3,a0
        return parseblock(ps, es);

    ret = execcmd();
     6c4:	00000097          	auipc	ra,0x0
     6c8:	bb4080e7          	jalr	-1100(ra) # 278 <execcmd>
     6cc:	8c2a                	mv	s8,a0
    cmd = (struct execcmd *)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     6ce:	8656                	mv	a2,s5
     6d0:	85d2                	mv	a1,s4
     6d2:	00000097          	auipc	ra,0x0
     6d6:	ec4080e7          	jalr	-316(ra) # 596 <parseredirs>
     6da:	84aa                	mv	s1,a0
    while (!peek(ps, es, "|)&;"))
     6dc:	008c0913          	addi	s2,s8,8
     6e0:	00001b17          	auipc	s6,0x1
     6e4:	190b0b13          	addi	s6,s6,400 # 1870 <malloc+0x182>
    {
        if ((tok = gettoken(ps, es, &q, &eq)) == 0)
            break;
        if (tok != 'a')
     6e8:	06100c93          	li	s9,97
            panic("syntax");
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if (argc >= MAXARGS)
     6ec:	4ba9                	li	s7,10
    while (!peek(ps, es, "|)&;"))
     6ee:	a0b1                	j	73a <parseexec+0xa8>
        return parseblock(ps, es);
     6f0:	85d6                	mv	a1,s5
     6f2:	8552                	mv	a0,s4
     6f4:	00000097          	auipc	ra,0x0
     6f8:	1bc080e7          	jalr	444(ra) # 8b0 <parseblock>
     6fc:	84aa                	mv	s1,a0
        ret = parseredirs(ret, ps, es);
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     6fe:	8526                	mv	a0,s1
     700:	70a6                	ld	ra,104(sp)
     702:	7406                	ld	s0,96(sp)
     704:	64e6                	ld	s1,88(sp)
     706:	6946                	ld	s2,80(sp)
     708:	69a6                	ld	s3,72(sp)
     70a:	6a06                	ld	s4,64(sp)
     70c:	7ae2                	ld	s5,56(sp)
     70e:	7b42                	ld	s6,48(sp)
     710:	7ba2                	ld	s7,40(sp)
     712:	7c02                	ld	s8,32(sp)
     714:	6ce2                	ld	s9,24(sp)
     716:	6165                	addi	sp,sp,112
     718:	8082                	ret
            panic("syntax");
     71a:	00001517          	auipc	a0,0x1
     71e:	13e50513          	addi	a0,a0,318 # 1858 <malloc+0x16a>
     722:	00000097          	auipc	ra,0x0
     726:	934080e7          	jalr	-1740(ra) # 56 <panic>
        ret = parseredirs(ret, ps, es);
     72a:	8656                	mv	a2,s5
     72c:	85d2                	mv	a1,s4
     72e:	8526                	mv	a0,s1
     730:	00000097          	auipc	ra,0x0
     734:	e66080e7          	jalr	-410(ra) # 596 <parseredirs>
     738:	84aa                	mv	s1,a0
    while (!peek(ps, es, "|)&;"))
     73a:	865a                	mv	a2,s6
     73c:	85d6                	mv	a1,s5
     73e:	8552                	mv	a0,s4
     740:	00000097          	auipc	ra,0x0
     744:	dea080e7          	jalr	-534(ra) # 52a <peek>
     748:	e131                	bnez	a0,78c <parseexec+0xfa>
        if ((tok = gettoken(ps, es, &q, &eq)) == 0)
     74a:	f9040693          	addi	a3,s0,-112
     74e:	f9840613          	addi	a2,s0,-104
     752:	85d6                	mv	a1,s5
     754:	8552                	mv	a0,s4
     756:	00000097          	auipc	ra,0x0
     75a:	c88080e7          	jalr	-888(ra) # 3de <gettoken>
     75e:	c51d                	beqz	a0,78c <parseexec+0xfa>
        if (tok != 'a')
     760:	fb951de3          	bne	a0,s9,71a <parseexec+0x88>
        cmd->argv[argc] = q;
     764:	f9843783          	ld	a5,-104(s0)
     768:	00f93023          	sd	a5,0(s2)
        cmd->eargv[argc] = eq;
     76c:	f9043783          	ld	a5,-112(s0)
     770:	04f93823          	sd	a5,80(s2)
        argc++;
     774:	2985                	addiw	s3,s3,1
        if (argc >= MAXARGS)
     776:	0921                	addi	s2,s2,8
     778:	fb7999e3          	bne	s3,s7,72a <parseexec+0x98>
            panic("too many args");
     77c:	00001517          	auipc	a0,0x1
     780:	0e450513          	addi	a0,a0,228 # 1860 <malloc+0x172>
     784:	00000097          	auipc	ra,0x0
     788:	8d2080e7          	jalr	-1838(ra) # 56 <panic>
    cmd->argv[argc] = 0;
     78c:	098e                	slli	s3,s3,0x3
     78e:	9c4e                	add	s8,s8,s3
     790:	000c3423          	sd	zero,8(s8)
    cmd->eargv[argc] = 0;
     794:	040c3c23          	sd	zero,88(s8)
    return ret;
     798:	b79d                	j	6fe <parseexec+0x6c>

000000000000079a <parsepipe>:
{
     79a:	7179                	addi	sp,sp,-48
     79c:	f406                	sd	ra,40(sp)
     79e:	f022                	sd	s0,32(sp)
     7a0:	ec26                	sd	s1,24(sp)
     7a2:	e84a                	sd	s2,16(sp)
     7a4:	e44e                	sd	s3,8(sp)
     7a6:	1800                	addi	s0,sp,48
     7a8:	892a                	mv	s2,a0
     7aa:	89ae                	mv	s3,a1
    cmd = parseexec(ps, es);
     7ac:	00000097          	auipc	ra,0x0
     7b0:	ee6080e7          	jalr	-282(ra) # 692 <parseexec>
     7b4:	84aa                	mv	s1,a0
    if (peek(ps, es, "|"))
     7b6:	00001617          	auipc	a2,0x1
     7ba:	0c260613          	addi	a2,a2,194 # 1878 <malloc+0x18a>
     7be:	85ce                	mv	a1,s3
     7c0:	854a                	mv	a0,s2
     7c2:	00000097          	auipc	ra,0x0
     7c6:	d68080e7          	jalr	-664(ra) # 52a <peek>
     7ca:	e909                	bnez	a0,7dc <parsepipe+0x42>
}
     7cc:	8526                	mv	a0,s1
     7ce:	70a2                	ld	ra,40(sp)
     7d0:	7402                	ld	s0,32(sp)
     7d2:	64e2                	ld	s1,24(sp)
     7d4:	6942                	ld	s2,16(sp)
     7d6:	69a2                	ld	s3,8(sp)
     7d8:	6145                	addi	sp,sp,48
     7da:	8082                	ret
        gettoken(ps, es, 0, 0);
     7dc:	4681                	li	a3,0
     7de:	4601                	li	a2,0
     7e0:	85ce                	mv	a1,s3
     7e2:	854a                	mv	a0,s2
     7e4:	00000097          	auipc	ra,0x0
     7e8:	bfa080e7          	jalr	-1030(ra) # 3de <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     7ec:	85ce                	mv	a1,s3
     7ee:	854a                	mv	a0,s2
     7f0:	00000097          	auipc	ra,0x0
     7f4:	faa080e7          	jalr	-86(ra) # 79a <parsepipe>
     7f8:	85aa                	mv	a1,a0
     7fa:	8526                	mv	a0,s1
     7fc:	00000097          	auipc	ra,0x0
     800:	b1a080e7          	jalr	-1254(ra) # 316 <pipecmd>
     804:	84aa                	mv	s1,a0
    return cmd;
     806:	b7d9                	j	7cc <parsepipe+0x32>

0000000000000808 <parseline>:
{
     808:	7179                	addi	sp,sp,-48
     80a:	f406                	sd	ra,40(sp)
     80c:	f022                	sd	s0,32(sp)
     80e:	ec26                	sd	s1,24(sp)
     810:	e84a                	sd	s2,16(sp)
     812:	e44e                	sd	s3,8(sp)
     814:	e052                	sd	s4,0(sp)
     816:	1800                	addi	s0,sp,48
     818:	892a                	mv	s2,a0
     81a:	89ae                	mv	s3,a1
    cmd = parsepipe(ps, es);
     81c:	00000097          	auipc	ra,0x0
     820:	f7e080e7          	jalr	-130(ra) # 79a <parsepipe>
     824:	84aa                	mv	s1,a0
    while (peek(ps, es, "&"))
     826:	00001a17          	auipc	s4,0x1
     82a:	05aa0a13          	addi	s4,s4,90 # 1880 <malloc+0x192>
     82e:	a839                	j	84c <parseline+0x44>
        gettoken(ps, es, 0, 0);
     830:	4681                	li	a3,0
     832:	4601                	li	a2,0
     834:	85ce                	mv	a1,s3
     836:	854a                	mv	a0,s2
     838:	00000097          	auipc	ra,0x0
     83c:	ba6080e7          	jalr	-1114(ra) # 3de <gettoken>
        cmd = backcmd(cmd);
     840:	8526                	mv	a0,s1
     842:	00000097          	auipc	ra,0x0
     846:	b60080e7          	jalr	-1184(ra) # 3a2 <backcmd>
     84a:	84aa                	mv	s1,a0
    while (peek(ps, es, "&"))
     84c:	8652                	mv	a2,s4
     84e:	85ce                	mv	a1,s3
     850:	854a                	mv	a0,s2
     852:	00000097          	auipc	ra,0x0
     856:	cd8080e7          	jalr	-808(ra) # 52a <peek>
     85a:	f979                	bnez	a0,830 <parseline+0x28>
    if (peek(ps, es, ";"))
     85c:	00001617          	auipc	a2,0x1
     860:	02c60613          	addi	a2,a2,44 # 1888 <malloc+0x19a>
     864:	85ce                	mv	a1,s3
     866:	854a                	mv	a0,s2
     868:	00000097          	auipc	ra,0x0
     86c:	cc2080e7          	jalr	-830(ra) # 52a <peek>
     870:	e911                	bnez	a0,884 <parseline+0x7c>
}
     872:	8526                	mv	a0,s1
     874:	70a2                	ld	ra,40(sp)
     876:	7402                	ld	s0,32(sp)
     878:	64e2                	ld	s1,24(sp)
     87a:	6942                	ld	s2,16(sp)
     87c:	69a2                	ld	s3,8(sp)
     87e:	6a02                	ld	s4,0(sp)
     880:	6145                	addi	sp,sp,48
     882:	8082                	ret
        gettoken(ps, es, 0, 0);
     884:	4681                	li	a3,0
     886:	4601                	li	a2,0
     888:	85ce                	mv	a1,s3
     88a:	854a                	mv	a0,s2
     88c:	00000097          	auipc	ra,0x0
     890:	b52080e7          	jalr	-1198(ra) # 3de <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     894:	85ce                	mv	a1,s3
     896:	854a                	mv	a0,s2
     898:	00000097          	auipc	ra,0x0
     89c:	f70080e7          	jalr	-144(ra) # 808 <parseline>
     8a0:	85aa                	mv	a1,a0
     8a2:	8526                	mv	a0,s1
     8a4:	00000097          	auipc	ra,0x0
     8a8:	ab8080e7          	jalr	-1352(ra) # 35c <listcmd>
     8ac:	84aa                	mv	s1,a0
    return cmd;
     8ae:	b7d1                	j	872 <parseline+0x6a>

00000000000008b0 <parseblock>:
{
     8b0:	7179                	addi	sp,sp,-48
     8b2:	f406                	sd	ra,40(sp)
     8b4:	f022                	sd	s0,32(sp)
     8b6:	ec26                	sd	s1,24(sp)
     8b8:	e84a                	sd	s2,16(sp)
     8ba:	e44e                	sd	s3,8(sp)
     8bc:	1800                	addi	s0,sp,48
     8be:	84aa                	mv	s1,a0
     8c0:	892e                	mv	s2,a1
    if (!peek(ps, es, "("))
     8c2:	00001617          	auipc	a2,0x1
     8c6:	f8e60613          	addi	a2,a2,-114 # 1850 <malloc+0x162>
     8ca:	00000097          	auipc	ra,0x0
     8ce:	c60080e7          	jalr	-928(ra) # 52a <peek>
     8d2:	c12d                	beqz	a0,934 <parseblock+0x84>
    gettoken(ps, es, 0, 0);
     8d4:	4681                	li	a3,0
     8d6:	4601                	li	a2,0
     8d8:	85ca                	mv	a1,s2
     8da:	8526                	mv	a0,s1
     8dc:	00000097          	auipc	ra,0x0
     8e0:	b02080e7          	jalr	-1278(ra) # 3de <gettoken>
    cmd = parseline(ps, es);
     8e4:	85ca                	mv	a1,s2
     8e6:	8526                	mv	a0,s1
     8e8:	00000097          	auipc	ra,0x0
     8ec:	f20080e7          	jalr	-224(ra) # 808 <parseline>
     8f0:	89aa                	mv	s3,a0
    if (!peek(ps, es, ")"))
     8f2:	00001617          	auipc	a2,0x1
     8f6:	fae60613          	addi	a2,a2,-82 # 18a0 <malloc+0x1b2>
     8fa:	85ca                	mv	a1,s2
     8fc:	8526                	mv	a0,s1
     8fe:	00000097          	auipc	ra,0x0
     902:	c2c080e7          	jalr	-980(ra) # 52a <peek>
     906:	cd1d                	beqz	a0,944 <parseblock+0x94>
    gettoken(ps, es, 0, 0);
     908:	4681                	li	a3,0
     90a:	4601                	li	a2,0
     90c:	85ca                	mv	a1,s2
     90e:	8526                	mv	a0,s1
     910:	00000097          	auipc	ra,0x0
     914:	ace080e7          	jalr	-1330(ra) # 3de <gettoken>
    cmd = parseredirs(cmd, ps, es);
     918:	864a                	mv	a2,s2
     91a:	85a6                	mv	a1,s1
     91c:	854e                	mv	a0,s3
     91e:	00000097          	auipc	ra,0x0
     922:	c78080e7          	jalr	-904(ra) # 596 <parseredirs>
}
     926:	70a2                	ld	ra,40(sp)
     928:	7402                	ld	s0,32(sp)
     92a:	64e2                	ld	s1,24(sp)
     92c:	6942                	ld	s2,16(sp)
     92e:	69a2                	ld	s3,8(sp)
     930:	6145                	addi	sp,sp,48
     932:	8082                	ret
        panic("parseblock");
     934:	00001517          	auipc	a0,0x1
     938:	f5c50513          	addi	a0,a0,-164 # 1890 <malloc+0x1a2>
     93c:	fffff097          	auipc	ra,0xfffff
     940:	71a080e7          	jalr	1818(ra) # 56 <panic>
        panic("syntax - missing )");
     944:	00001517          	auipc	a0,0x1
     948:	f6450513          	addi	a0,a0,-156 # 18a8 <malloc+0x1ba>
     94c:	fffff097          	auipc	ra,0xfffff
     950:	70a080e7          	jalr	1802(ra) # 56 <panic>

0000000000000954 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd *
nulterminate(struct cmd *cmd)
{
     954:	1101                	addi	sp,sp,-32
     956:	ec06                	sd	ra,24(sp)
     958:	e822                	sd	s0,16(sp)
     95a:	e426                	sd	s1,8(sp)
     95c:	1000                	addi	s0,sp,32
     95e:	84aa                	mv	s1,a0
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if (cmd == 0)
     960:	c521                	beqz	a0,9a8 <nulterminate+0x54>
        return 0;

    switch (cmd->type)
     962:	4118                	lw	a4,0(a0)
     964:	4795                	li	a5,5
     966:	04e7e163          	bltu	a5,a4,9a8 <nulterminate+0x54>
     96a:	00056783          	lwu	a5,0(a0)
     96e:	078a                	slli	a5,a5,0x2
     970:	00001717          	auipc	a4,0x1
     974:	fac70713          	addi	a4,a4,-84 # 191c <malloc+0x22e>
     978:	97ba                	add	a5,a5,a4
     97a:	439c                	lw	a5,0(a5)
     97c:	97ba                	add	a5,a5,a4
     97e:	8782                	jr	a5
    {
    case EXEC:
        ecmd = (struct execcmd *)cmd;
        for (i = 0; ecmd->argv[i]; i++)
     980:	651c                	ld	a5,8(a0)
     982:	c39d                	beqz	a5,9a8 <nulterminate+0x54>
     984:	01050793          	addi	a5,a0,16
            *ecmd->eargv[i] = 0;
     988:	67b8                	ld	a4,72(a5)
     98a:	00070023          	sb	zero,0(a4)
        for (i = 0; ecmd->argv[i]; i++)
     98e:	07a1                	addi	a5,a5,8
     990:	ff87b703          	ld	a4,-8(a5)
     994:	fb75                	bnez	a4,988 <nulterminate+0x34>
     996:	a809                	j	9a8 <nulterminate+0x54>
        break;

    case REDIR:
        rcmd = (struct redircmd *)cmd;
        nulterminate(rcmd->cmd);
     998:	6508                	ld	a0,8(a0)
     99a:	00000097          	auipc	ra,0x0
     99e:	fba080e7          	jalr	-70(ra) # 954 <nulterminate>
        *rcmd->efile = 0;
     9a2:	6c9c                	ld	a5,24(s1)
     9a4:	00078023          	sb	zero,0(a5)
        bcmd = (struct backcmd *)cmd;
        nulterminate(bcmd->cmd);
        break;
    }
    return cmd;
}
     9a8:	8526                	mv	a0,s1
     9aa:	60e2                	ld	ra,24(sp)
     9ac:	6442                	ld	s0,16(sp)
     9ae:	64a2                	ld	s1,8(sp)
     9b0:	6105                	addi	sp,sp,32
     9b2:	8082                	ret
        nulterminate(pcmd->left);
     9b4:	6508                	ld	a0,8(a0)
     9b6:	00000097          	auipc	ra,0x0
     9ba:	f9e080e7          	jalr	-98(ra) # 954 <nulterminate>
        nulterminate(pcmd->right);
     9be:	6888                	ld	a0,16(s1)
     9c0:	00000097          	auipc	ra,0x0
     9c4:	f94080e7          	jalr	-108(ra) # 954 <nulterminate>
        break;
     9c8:	b7c5                	j	9a8 <nulterminate+0x54>
        nulterminate(lcmd->left);
     9ca:	6508                	ld	a0,8(a0)
     9cc:	00000097          	auipc	ra,0x0
     9d0:	f88080e7          	jalr	-120(ra) # 954 <nulterminate>
        nulterminate(lcmd->right);
     9d4:	6888                	ld	a0,16(s1)
     9d6:	00000097          	auipc	ra,0x0
     9da:	f7e080e7          	jalr	-130(ra) # 954 <nulterminate>
        break;
     9de:	b7e9                	j	9a8 <nulterminate+0x54>
        nulterminate(bcmd->cmd);
     9e0:	6508                	ld	a0,8(a0)
     9e2:	00000097          	auipc	ra,0x0
     9e6:	f72080e7          	jalr	-142(ra) # 954 <nulterminate>
        break;
     9ea:	bf7d                	j	9a8 <nulterminate+0x54>

00000000000009ec <parsecmd>:
{
     9ec:	7179                	addi	sp,sp,-48
     9ee:	f406                	sd	ra,40(sp)
     9f0:	f022                	sd	s0,32(sp)
     9f2:	ec26                	sd	s1,24(sp)
     9f4:	e84a                	sd	s2,16(sp)
     9f6:	1800                	addi	s0,sp,48
     9f8:	fca43c23          	sd	a0,-40(s0)
    es = s + strlen(s);
     9fc:	84aa                	mv	s1,a0
     9fe:	00000097          	auipc	ra,0x0
     a02:	694080e7          	jalr	1684(ra) # 1092 <strlen>
     a06:	1502                	slli	a0,a0,0x20
     a08:	9101                	srli	a0,a0,0x20
     a0a:	94aa                	add	s1,s1,a0
    cmd = parseline(&s, es);
     a0c:	85a6                	mv	a1,s1
     a0e:	fd840513          	addi	a0,s0,-40
     a12:	00000097          	auipc	ra,0x0
     a16:	df6080e7          	jalr	-522(ra) # 808 <parseline>
     a1a:	892a                	mv	s2,a0
    peek(&s, es, "");
     a1c:	00001617          	auipc	a2,0x1
     a20:	ea460613          	addi	a2,a2,-348 # 18c0 <malloc+0x1d2>
     a24:	85a6                	mv	a1,s1
     a26:	fd840513          	addi	a0,s0,-40
     a2a:	00000097          	auipc	ra,0x0
     a2e:	b00080e7          	jalr	-1280(ra) # 52a <peek>
    if (s != es)
     a32:	fd843603          	ld	a2,-40(s0)
     a36:	00961e63          	bne	a2,s1,a52 <parsecmd+0x66>
    nulterminate(cmd);
     a3a:	854a                	mv	a0,s2
     a3c:	00000097          	auipc	ra,0x0
     a40:	f18080e7          	jalr	-232(ra) # 954 <nulterminate>
}
     a44:	854a                	mv	a0,s2
     a46:	70a2                	ld	ra,40(sp)
     a48:	7402                	ld	s0,32(sp)
     a4a:	64e2                	ld	s1,24(sp)
     a4c:	6942                	ld	s2,16(sp)
     a4e:	6145                	addi	sp,sp,48
     a50:	8082                	ret
        fprintf(2, "leftovers: %s\n", s);
     a52:	00001597          	auipc	a1,0x1
     a56:	e7658593          	addi	a1,a1,-394 # 18c8 <malloc+0x1da>
     a5a:	4509                	li	a0,2
     a5c:	00001097          	auipc	ra,0x1
     a60:	bac080e7          	jalr	-1108(ra) # 1608 <fprintf>
        panic("syntax");
     a64:	00001517          	auipc	a0,0x1
     a68:	df450513          	addi	a0,a0,-524 # 1858 <malloc+0x16a>
     a6c:	fffff097          	auipc	ra,0xfffff
     a70:	5ea080e7          	jalr	1514(ra) # 56 <panic>

0000000000000a74 <parse_buffer>:
{
     a74:	1101                	addi	sp,sp,-32
     a76:	ec06                	sd	ra,24(sp)
     a78:	e822                	sd	s0,16(sp)
     a7a:	e426                	sd	s1,8(sp)
     a7c:	1000                	addi	s0,sp,32
     a7e:	84aa                	mv	s1,a0
    if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ')
     a80:	00054783          	lbu	a5,0(a0)
     a84:	06300713          	li	a4,99
     a88:	02e78b63          	beq	a5,a4,abe <parse_buffer+0x4a>
    if (buf[0] == 'e' &&
     a8c:	06500713          	li	a4,101
     a90:	00e79863          	bne	a5,a4,aa0 <parse_buffer+0x2c>
     a94:	00154703          	lbu	a4,1(a0)
     a98:	07800793          	li	a5,120
     a9c:	06f70b63          	beq	a4,a5,b12 <parse_buffer+0x9e>
    if (fork1() == 0)
     aa0:	fffff097          	auipc	ra,0xfffff
     aa4:	5dc080e7          	jalr	1500(ra) # 7c <fork1>
     aa8:	c551                	beqz	a0,b34 <parse_buffer+0xc0>
    wait(0);
     aaa:	4501                	li	a0,0
     aac:	00001097          	auipc	ra,0x1
     ab0:	812080e7          	jalr	-2030(ra) # 12be <wait>
}
     ab4:	60e2                	ld	ra,24(sp)
     ab6:	6442                	ld	s0,16(sp)
     ab8:	64a2                	ld	s1,8(sp)
     aba:	6105                	addi	sp,sp,32
     abc:	8082                	ret
    if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ')
     abe:	00154703          	lbu	a4,1(a0)
     ac2:	06400793          	li	a5,100
     ac6:	fcf71de3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
     aca:	00254703          	lbu	a4,2(a0)
     ace:	02000793          	li	a5,32
     ad2:	fcf717e3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
        buf[strlen(buf) - 1] = 0; // chop \n
     ad6:	00000097          	auipc	ra,0x0
     ada:	5bc080e7          	jalr	1468(ra) # 1092 <strlen>
     ade:	fff5079b          	addiw	a5,a0,-1
     ae2:	1782                	slli	a5,a5,0x20
     ae4:	9381                	srli	a5,a5,0x20
     ae6:	97a6                	add	a5,a5,s1
     ae8:	00078023          	sb	zero,0(a5)
        if (chdir(buf + 3) < 0)
     aec:	048d                	addi	s1,s1,3
     aee:	8526                	mv	a0,s1
     af0:	00001097          	auipc	ra,0x1
     af4:	836080e7          	jalr	-1994(ra) # 1326 <chdir>
     af8:	fa055ee3          	bgez	a0,ab4 <parse_buffer+0x40>
            fprintf(2, "cannot cd %s\n", buf + 3);
     afc:	8626                	mv	a2,s1
     afe:	00001597          	auipc	a1,0x1
     b02:	dda58593          	addi	a1,a1,-550 # 18d8 <malloc+0x1ea>
     b06:	4509                	li	a0,2
     b08:	00001097          	auipc	ra,0x1
     b0c:	b00080e7          	jalr	-1280(ra) # 1608 <fprintf>
     b10:	b755                	j	ab4 <parse_buffer+0x40>
        buf[1] == 'x' &&
     b12:	00254703          	lbu	a4,2(a0)
     b16:	06900793          	li	a5,105
     b1a:	f8f713e3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
        buf[2] == 'i' &&
     b1e:	00354703          	lbu	a4,3(a0)
     b22:	07400793          	li	a5,116
     b26:	f6f71de3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
        exit(0);
     b2a:	4501                	li	a0,0
     b2c:	00000097          	auipc	ra,0x0
     b30:	78a080e7          	jalr	1930(ra) # 12b6 <exit>
        runcmd(parsecmd(buf));
     b34:	8526                	mv	a0,s1
     b36:	00000097          	auipc	ra,0x0
     b3a:	eb6080e7          	jalr	-330(ra) # 9ec <parsecmd>
     b3e:	fffff097          	auipc	ra,0xfffff
     b42:	56c080e7          	jalr	1388(ra) # aa <runcmd>

0000000000000b46 <main>:
{
     b46:	7179                	addi	sp,sp,-48
     b48:	f406                	sd	ra,40(sp)
     b4a:	f022                	sd	s0,32(sp)
     b4c:	ec26                	sd	s1,24(sp)
     b4e:	e84a                	sd	s2,16(sp)
     b50:	e44e                	sd	s3,8(sp)
     b52:	1800                	addi	s0,sp,48
     b54:	892a                	mv	s2,a0
     b56:	89ae                	mv	s3,a1
    while ((fd = open("console", O_RDWR)) >= 0)
     b58:	00001497          	auipc	s1,0x1
     b5c:	d9048493          	addi	s1,s1,-624 # 18e8 <malloc+0x1fa>
     b60:	4589                	li	a1,2
     b62:	8526                	mv	a0,s1
     b64:	00000097          	auipc	ra,0x0
     b68:	792080e7          	jalr	1938(ra) # 12f6 <open>
     b6c:	00054963          	bltz	a0,b7e <main+0x38>
        if (fd >= 3)
     b70:	4789                	li	a5,2
     b72:	fea7d7e3          	bge	a5,a0,b60 <main+0x1a>
            close(fd);
     b76:	00000097          	auipc	ra,0x0
     b7a:	768080e7          	jalr	1896(ra) # 12de <close>
    if (argc == 2)
     b7e:	4789                	li	a5,2
    while (getcmd(buf, sizeof(buf)) >= 0)
     b80:	00001497          	auipc	s1,0x1
     b84:	4b048493          	addi	s1,s1,1200 # 2030 <buf.0>
    if (argc == 2)
     b88:	08f91463          	bne	s2,a5,c10 <main+0xca>
        char *shell_script_file = argv[1];
     b8c:	0089b483          	ld	s1,8(s3)
        int shfd = open(shell_script_file, O_RDWR);
     b90:	4589                	li	a1,2
     b92:	8526                	mv	a0,s1
     b94:	00000097          	auipc	ra,0x0
     b98:	762080e7          	jalr	1890(ra) # 12f6 <open>
     b9c:	892a                	mv	s2,a0
        if (shfd < 0)
     b9e:	04054663          	bltz	a0,bea <main+0xa4>
        read(shfd, buf, sizeof(buf));
     ba2:	07800613          	li	a2,120
     ba6:	00001597          	auipc	a1,0x1
     baa:	48a58593          	addi	a1,a1,1162 # 2030 <buf.0>
     bae:	00000097          	auipc	ra,0x0
     bb2:	720080e7          	jalr	1824(ra) # 12ce <read>
            parse_buffer(buf);
     bb6:	00001497          	auipc	s1,0x1
     bba:	47a48493          	addi	s1,s1,1146 # 2030 <buf.0>
     bbe:	8526                	mv	a0,s1
     bc0:	00000097          	auipc	ra,0x0
     bc4:	eb4080e7          	jalr	-332(ra) # a74 <parse_buffer>
        } while (read(shfd, buf, sizeof(buf)) == sizeof(buf));
     bc8:	07800613          	li	a2,120
     bcc:	85a6                	mv	a1,s1
     bce:	854a                	mv	a0,s2
     bd0:	00000097          	auipc	ra,0x0
     bd4:	6fe080e7          	jalr	1790(ra) # 12ce <read>
     bd8:	07800793          	li	a5,120
     bdc:	fef501e3          	beq	a0,a5,bbe <main+0x78>
        exit(0);
     be0:	4501                	li	a0,0
     be2:	00000097          	auipc	ra,0x0
     be6:	6d4080e7          	jalr	1748(ra) # 12b6 <exit>
            printf("Failed to open %s\n", shell_script_file);
     bea:	85a6                	mv	a1,s1
     bec:	00001517          	auipc	a0,0x1
     bf0:	d0450513          	addi	a0,a0,-764 # 18f0 <malloc+0x202>
     bf4:	00001097          	auipc	ra,0x1
     bf8:	a42080e7          	jalr	-1470(ra) # 1636 <printf>
            exit(1);
     bfc:	4505                	li	a0,1
     bfe:	00000097          	auipc	ra,0x0
     c02:	6b8080e7          	jalr	1720(ra) # 12b6 <exit>
        parse_buffer(buf);
     c06:	8526                	mv	a0,s1
     c08:	00000097          	auipc	ra,0x0
     c0c:	e6c080e7          	jalr	-404(ra) # a74 <parse_buffer>
    while (getcmd(buf, sizeof(buf)) >= 0)
     c10:	07800593          	li	a1,120
     c14:	8526                	mv	a0,s1
     c16:	fffff097          	auipc	ra,0xfffff
     c1a:	3ea080e7          	jalr	1002(ra) # 0 <getcmd>
     c1e:	fe0554e3          	bgez	a0,c06 <main+0xc0>
    exit(0);
     c22:	4501                	li	a0,0
     c24:	00000097          	auipc	ra,0x0
     c28:	692080e7          	jalr	1682(ra) # 12b6 <exit>

0000000000000c2c <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
     c2c:	1141                	addi	sp,sp,-16
     c2e:	e422                	sd	s0,8(sp)
     c30:	0800                	addi	s0,sp,16
    lk->name = name;
     c32:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
     c34:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
     c38:	57fd                	li	a5,-1
     c3a:	00f50823          	sb	a5,16(a0)
}
     c3e:	6422                	ld	s0,8(sp)
     c40:	0141                	addi	sp,sp,16
     c42:	8082                	ret

0000000000000c44 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
     c44:	00054783          	lbu	a5,0(a0)
     c48:	e399                	bnez	a5,c4e <holding+0xa>
     c4a:	4501                	li	a0,0
}
     c4c:	8082                	ret
{
     c4e:	1101                	addi	sp,sp,-32
     c50:	ec06                	sd	ra,24(sp)
     c52:	e822                	sd	s0,16(sp)
     c54:	e426                	sd	s1,8(sp)
     c56:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
     c58:	01054483          	lbu	s1,16(a0)
     c5c:	00000097          	auipc	ra,0x0
     c60:	340080e7          	jalr	832(ra) # f9c <twhoami>
     c64:	2501                	sext.w	a0,a0
     c66:	40a48533          	sub	a0,s1,a0
     c6a:	00153513          	seqz	a0,a0
}
     c6e:	60e2                	ld	ra,24(sp)
     c70:	6442                	ld	s0,16(sp)
     c72:	64a2                	ld	s1,8(sp)
     c74:	6105                	addi	sp,sp,32
     c76:	8082                	ret

0000000000000c78 <acquire>:

void acquire(struct lock *lk)
{
     c78:	7179                	addi	sp,sp,-48
     c7a:	f406                	sd	ra,40(sp)
     c7c:	f022                	sd	s0,32(sp)
     c7e:	ec26                	sd	s1,24(sp)
     c80:	e84a                	sd	s2,16(sp)
     c82:	e44e                	sd	s3,8(sp)
     c84:	e052                	sd	s4,0(sp)
     c86:	1800                	addi	s0,sp,48
     c88:	8a2a                	mv	s4,a0
    if (holding(lk))
     c8a:	00000097          	auipc	ra,0x0
     c8e:	fba080e7          	jalr	-70(ra) # c44 <holding>
     c92:	e919                	bnez	a0,ca8 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     c94:	ffca7493          	andi	s1,s4,-4
     c98:	003a7913          	andi	s2,s4,3
     c9c:	0039191b          	slliw	s2,s2,0x3
     ca0:	4985                	li	s3,1
     ca2:	012999bb          	sllw	s3,s3,s2
     ca6:	a015                	j	cca <acquire+0x52>
        printf("re-acquiring lock we already hold");
     ca8:	00001517          	auipc	a0,0x1
     cac:	c9050513          	addi	a0,a0,-880 # 1938 <malloc+0x24a>
     cb0:	00001097          	auipc	ra,0x1
     cb4:	986080e7          	jalr	-1658(ra) # 1636 <printf>
        exit(-1);
     cb8:	557d                	li	a0,-1
     cba:	00000097          	auipc	ra,0x0
     cbe:	5fc080e7          	jalr	1532(ra) # 12b6 <exit>
    {
        // give up the cpu for other threads
        tyield();
     cc2:	00000097          	auipc	ra,0x0
     cc6:	258080e7          	jalr	600(ra) # f1a <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     cca:	4534a7af          	amoor.w.aq	a5,s3,(s1)
     cce:	0127d7bb          	srlw	a5,a5,s2
     cd2:	0ff7f793          	zext.b	a5,a5
     cd6:	f7f5                	bnez	a5,cc2 <acquire+0x4a>
    }

    __sync_synchronize();
     cd8:	0ff0000f          	fence

    lk->tid = twhoami();
     cdc:	00000097          	auipc	ra,0x0
     ce0:	2c0080e7          	jalr	704(ra) # f9c <twhoami>
     ce4:	00aa0823          	sb	a0,16(s4)
}
     ce8:	70a2                	ld	ra,40(sp)
     cea:	7402                	ld	s0,32(sp)
     cec:	64e2                	ld	s1,24(sp)
     cee:	6942                	ld	s2,16(sp)
     cf0:	69a2                	ld	s3,8(sp)
     cf2:	6a02                	ld	s4,0(sp)
     cf4:	6145                	addi	sp,sp,48
     cf6:	8082                	ret

0000000000000cf8 <release>:

void release(struct lock *lk)
{
     cf8:	1101                	addi	sp,sp,-32
     cfa:	ec06                	sd	ra,24(sp)
     cfc:	e822                	sd	s0,16(sp)
     cfe:	e426                	sd	s1,8(sp)
     d00:	1000                	addi	s0,sp,32
     d02:	84aa                	mv	s1,a0
    if (!holding(lk))
     d04:	00000097          	auipc	ra,0x0
     d08:	f40080e7          	jalr	-192(ra) # c44 <holding>
     d0c:	c11d                	beqz	a0,d32 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
     d0e:	57fd                	li	a5,-1
     d10:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
     d14:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
     d18:	0ff0000f          	fence
     d1c:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
     d20:	00000097          	auipc	ra,0x0
     d24:	1fa080e7          	jalr	506(ra) # f1a <tyield>
}
     d28:	60e2                	ld	ra,24(sp)
     d2a:	6442                	ld	s0,16(sp)
     d2c:	64a2                	ld	s1,8(sp)
     d2e:	6105                	addi	sp,sp,32
     d30:	8082                	ret
        printf("releasing lock we are not holding");
     d32:	00001517          	auipc	a0,0x1
     d36:	c2e50513          	addi	a0,a0,-978 # 1960 <malloc+0x272>
     d3a:	00001097          	auipc	ra,0x1
     d3e:	8fc080e7          	jalr	-1796(ra) # 1636 <printf>
        exit(-1);
     d42:	557d                	li	a0,-1
     d44:	00000097          	auipc	ra,0x0
     d48:	572080e7          	jalr	1394(ra) # 12b6 <exit>

0000000000000d4c <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
     d4c:	1141                	addi	sp,sp,-16
     d4e:	e406                	sd	ra,8(sp)
     d50:	e022                	sd	s0,0(sp)
     d52:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     d54:	09800513          	li	a0,152
     d58:	00001097          	auipc	ra,0x1
     d5c:	996080e7          	jalr	-1642(ra) # 16ee <malloc>

    main_thread->tid = next_tid;
     d60:	00001797          	auipc	a5,0x1
     d64:	2b078793          	addi	a5,a5,688 # 2010 <next_tid>
     d68:	4398                	lw	a4,0(a5)
     d6a:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
     d6e:	4398                	lw	a4,0(a5)
     d70:	2705                	addiw	a4,a4,1
     d72:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
     d74:	4791                	li	a5,4
     d76:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     d78:	00001797          	auipc	a5,0x1
     d7c:	2aa7b423          	sd	a0,680(a5) # 2020 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     d80:	00001797          	auipc	a5,0x1
     d84:	32878793          	addi	a5,a5,808 # 20a8 <threads>
     d88:	00001717          	auipc	a4,0x1
     d8c:	3a070713          	addi	a4,a4,928 # 2128 <base>
        threads[i] = NULL;
     d90:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     d94:	07a1                	addi	a5,a5,8
     d96:	fee79de3          	bne	a5,a4,d90 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     d9a:	00001797          	auipc	a5,0x1
     d9e:	30a7b723          	sd	a0,782(a5) # 20a8 <threads>
}
     da2:	60a2                	ld	ra,8(sp)
     da4:	6402                	ld	s0,0(sp)
     da6:	0141                	addi	sp,sp,16
     da8:	8082                	ret

0000000000000daa <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     daa:	00001517          	auipc	a0,0x1
     dae:	27653503          	ld	a0,630(a0) # 2020 <current_thread>
     db2:	00001717          	auipc	a4,0x1
     db6:	2f670713          	addi	a4,a4,758 # 20a8 <threads>
    for (int i = 0; i < 16; i++) {
     dba:	4781                	li	a5,0
     dbc:	4641                	li	a2,16
        if (threads[i] == current_thread) {
     dbe:	6314                	ld	a3,0(a4)
     dc0:	00a68763          	beq	a3,a0,dce <tsched+0x24>
    for (int i = 0; i < 16; i++) {
     dc4:	2785                	addiw	a5,a5,1
     dc6:	0721                	addi	a4,a4,8
     dc8:	fec79be3          	bne	a5,a2,dbe <tsched+0x14>
    int current_index = 0;
     dcc:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
     dce:	0017869b          	addiw	a3,a5,1
     dd2:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     dd6:	00001817          	auipc	a6,0x1
     dda:	2d280813          	addi	a6,a6,722 # 20a8 <threads>
     dde:	488d                	li	a7,3
     de0:	a021                	j	de8 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
     de2:	2685                	addiw	a3,a3,1
     de4:	04c68363          	beq	a3,a2,e2a <tsched+0x80>
        int next_index = (current_index + i) % 16;
     de8:	41f6d71b          	sraiw	a4,a3,0x1f
     dec:	01c7571b          	srliw	a4,a4,0x1c
     df0:	00d707bb          	addw	a5,a4,a3
     df4:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     df6:	9f99                	subw	a5,a5,a4
     df8:	078e                	slli	a5,a5,0x3
     dfa:	97c2                	add	a5,a5,a6
     dfc:	638c                	ld	a1,0(a5)
     dfe:	d1f5                	beqz	a1,de2 <tsched+0x38>
     e00:	5dbc                	lw	a5,120(a1)
     e02:	ff1790e3          	bne	a5,a7,de2 <tsched+0x38>
{
     e06:	1141                	addi	sp,sp,-16
     e08:	e406                	sd	ra,8(sp)
     e0a:	e022                	sd	s0,0(sp)
     e0c:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
     e0e:	00001797          	auipc	a5,0x1
     e12:	20b7b923          	sd	a1,530(a5) # 2020 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     e16:	05a1                	addi	a1,a1,8
     e18:	0521                	addi	a0,a0,8
     e1a:	00000097          	auipc	ra,0x0
     e1e:	19a080e7          	jalr	410(ra) # fb4 <tswtch>
        //printf("Thread switch complete\n");
    }
}
     e22:	60a2                	ld	ra,8(sp)
     e24:	6402                	ld	s0,0(sp)
     e26:	0141                	addi	sp,sp,16
     e28:	8082                	ret
     e2a:	8082                	ret

0000000000000e2c <thread_wrapper>:
{
     e2c:	1101                	addi	sp,sp,-32
     e2e:	ec06                	sd	ra,24(sp)
     e30:	e822                	sd	s0,16(sp)
     e32:	e426                	sd	s1,8(sp)
     e34:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
     e36:	00001497          	auipc	s1,0x1
     e3a:	1ea48493          	addi	s1,s1,490 # 2020 <current_thread>
     e3e:	609c                	ld	a5,0(s1)
     e40:	6b9c                	ld	a5,16(a5)
    func(arg);
     e42:	6398                	ld	a4,0(a5)
     e44:	6788                	ld	a0,8(a5)
     e46:	9702                	jalr	a4
    current_thread->state = EXITED;
     e48:	609c                	ld	a5,0(s1)
     e4a:	4719                	li	a4,6
     e4c:	dfb8                	sw	a4,120(a5)
    tsched();
     e4e:	00000097          	auipc	ra,0x0
     e52:	f5c080e7          	jalr	-164(ra) # daa <tsched>
}
     e56:	60e2                	ld	ra,24(sp)
     e58:	6442                	ld	s0,16(sp)
     e5a:	64a2                	ld	s1,8(sp)
     e5c:	6105                	addi	sp,sp,32
     e5e:	8082                	ret

0000000000000e60 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     e60:	7179                	addi	sp,sp,-48
     e62:	f406                	sd	ra,40(sp)
     e64:	f022                	sd	s0,32(sp)
     e66:	ec26                	sd	s1,24(sp)
     e68:	e84a                	sd	s2,16(sp)
     e6a:	e44e                	sd	s3,8(sp)
     e6c:	1800                	addi	s0,sp,48
     e6e:	84aa                	mv	s1,a0
     e70:	8932                	mv	s2,a2
     e72:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     e74:	09800513          	li	a0,152
     e78:	00001097          	auipc	ra,0x1
     e7c:	876080e7          	jalr	-1930(ra) # 16ee <malloc>
     e80:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     e82:	478d                	li	a5,3
     e84:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     e86:	609c                	ld	a5,0(s1)
     e88:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
     e8c:	609c                	ld	a5,0(s1)
     e8e:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
     e92:	6098                	ld	a4,0(s1)
     e94:	00001797          	auipc	a5,0x1
     e98:	17c78793          	addi	a5,a5,380 # 2010 <next_tid>
     e9c:	4394                	lw	a3,0(a5)
     e9e:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
     ea2:	4398                	lw	a4,0(a5)
     ea4:	2705                	addiw	a4,a4,1
     ea6:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
     ea8:	6505                	lui	a0,0x1
     eaa:	00001097          	auipc	ra,0x1
     eae:	844080e7          	jalr	-1980(ra) # 16ee <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
     eb2:	6785                	lui	a5,0x1
     eb4:	00a78733          	add	a4,a5,a0
     eb8:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
     ebc:	17c1                	addi	a5,a5,-16 # ff0 <tswtch+0x3c>
     ebe:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
     ec0:	01253023          	sd	s2,0(a0) # 1000 <tswtch+0x4c>

    (*thread)->tcontext.sp = stack_top;
     ec4:	609c                	ld	a5,0(s1)
     ec6:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
     ec8:	609c                	ld	a5,0(s1)
     eca:	00000717          	auipc	a4,0x0
     ece:	f6270713          	addi	a4,a4,-158 # e2c <thread_wrapper>
     ed2:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
     ed4:	00001717          	auipc	a4,0x1
     ed8:	1d470713          	addi	a4,a4,468 # 20a8 <threads>
     edc:	4781                	li	a5,0
     ede:	4641                	li	a2,16
        if (threads[i] == NULL) {
     ee0:	6314                	ld	a3,0(a4)
     ee2:	c29d                	beqz	a3,f08 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
     ee4:	2785                	addiw	a5,a5,1
     ee6:	0721                	addi	a4,a4,8
     ee8:	fec79ce3          	bne	a5,a2,ee0 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
     eec:	6088                	ld	a0,0(s1)
     eee:	00000097          	auipc	ra,0x0
     ef2:	77e080e7          	jalr	1918(ra) # 166c <free>
        *thread = NULL;
     ef6:	0004b023          	sd	zero,0(s1)
        return;
    }
}
     efa:	70a2                	ld	ra,40(sp)
     efc:	7402                	ld	s0,32(sp)
     efe:	64e2                	ld	s1,24(sp)
     f00:	6942                	ld	s2,16(sp)
     f02:	69a2                	ld	s3,8(sp)
     f04:	6145                	addi	sp,sp,48
     f06:	8082                	ret
            threads[i] = *thread;
     f08:	6094                	ld	a3,0(s1)
     f0a:	078e                	slli	a5,a5,0x3
     f0c:	00001717          	auipc	a4,0x1
     f10:	19c70713          	addi	a4,a4,412 # 20a8 <threads>
     f14:	97ba                	add	a5,a5,a4
     f16:	e394                	sd	a3,0(a5)
    if (!thread_added) {
     f18:	b7cd                	j	efa <tcreate+0x9a>

0000000000000f1a <tyield>:
    return 0;
}


void tyield()
{
     f1a:	1141                	addi	sp,sp,-16
     f1c:	e406                	sd	ra,8(sp)
     f1e:	e022                	sd	s0,0(sp)
     f20:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
     f22:	00001797          	auipc	a5,0x1
     f26:	0fe7b783          	ld	a5,254(a5) # 2020 <current_thread>
     f2a:	470d                	li	a4,3
     f2c:	dfb8                	sw	a4,120(a5)
    tsched();
     f2e:	00000097          	auipc	ra,0x0
     f32:	e7c080e7          	jalr	-388(ra) # daa <tsched>
}
     f36:	60a2                	ld	ra,8(sp)
     f38:	6402                	ld	s0,0(sp)
     f3a:	0141                	addi	sp,sp,16
     f3c:	8082                	ret

0000000000000f3e <tjoin>:
{
     f3e:	1101                	addi	sp,sp,-32
     f40:	ec06                	sd	ra,24(sp)
     f42:	e822                	sd	s0,16(sp)
     f44:	e426                	sd	s1,8(sp)
     f46:	e04a                	sd	s2,0(sp)
     f48:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
     f4a:	00001797          	auipc	a5,0x1
     f4e:	15e78793          	addi	a5,a5,350 # 20a8 <threads>
     f52:	00001697          	auipc	a3,0x1
     f56:	1d668693          	addi	a3,a3,470 # 2128 <base>
     f5a:	a021                	j	f62 <tjoin+0x24>
     f5c:	07a1                	addi	a5,a5,8
     f5e:	02d78b63          	beq	a5,a3,f94 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
     f62:	6384                	ld	s1,0(a5)
     f64:	dce5                	beqz	s1,f5c <tjoin+0x1e>
     f66:	0004c703          	lbu	a4,0(s1)
     f6a:	fea719e3          	bne	a4,a0,f5c <tjoin+0x1e>
    while (target_thread->state != EXITED) {
     f6e:	5cb8                	lw	a4,120(s1)
     f70:	4799                	li	a5,6
     f72:	4919                	li	s2,6
     f74:	02f70263          	beq	a4,a5,f98 <tjoin+0x5a>
        tyield();
     f78:	00000097          	auipc	ra,0x0
     f7c:	fa2080e7          	jalr	-94(ra) # f1a <tyield>
    while (target_thread->state != EXITED) {
     f80:	5cbc                	lw	a5,120(s1)
     f82:	ff279be3          	bne	a5,s2,f78 <tjoin+0x3a>
    return 0;
     f86:	4501                	li	a0,0
}
     f88:	60e2                	ld	ra,24(sp)
     f8a:	6442                	ld	s0,16(sp)
     f8c:	64a2                	ld	s1,8(sp)
     f8e:	6902                	ld	s2,0(sp)
     f90:	6105                	addi	sp,sp,32
     f92:	8082                	ret
        return -1;
     f94:	557d                	li	a0,-1
     f96:	bfcd                	j	f88 <tjoin+0x4a>
    return 0;
     f98:	4501                	li	a0,0
     f9a:	b7fd                	j	f88 <tjoin+0x4a>

0000000000000f9c <twhoami>:

uint8 twhoami()
{
     f9c:	1141                	addi	sp,sp,-16
     f9e:	e422                	sd	s0,8(sp)
     fa0:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
     fa2:	00001797          	auipc	a5,0x1
     fa6:	07e7b783          	ld	a5,126(a5) # 2020 <current_thread>
     faa:	0007c503          	lbu	a0,0(a5)
     fae:	6422                	ld	s0,8(sp)
     fb0:	0141                	addi	sp,sp,16
     fb2:	8082                	ret

0000000000000fb4 <tswtch>:
     fb4:	00153023          	sd	ra,0(a0)
     fb8:	00253423          	sd	sp,8(a0)
     fbc:	e900                	sd	s0,16(a0)
     fbe:	ed04                	sd	s1,24(a0)
     fc0:	03253023          	sd	s2,32(a0)
     fc4:	03353423          	sd	s3,40(a0)
     fc8:	03453823          	sd	s4,48(a0)
     fcc:	03553c23          	sd	s5,56(a0)
     fd0:	05653023          	sd	s6,64(a0)
     fd4:	05753423          	sd	s7,72(a0)
     fd8:	05853823          	sd	s8,80(a0)
     fdc:	05953c23          	sd	s9,88(a0)
     fe0:	07a53023          	sd	s10,96(a0)
     fe4:	07b53423          	sd	s11,104(a0)
     fe8:	0005b083          	ld	ra,0(a1)
     fec:	0085b103          	ld	sp,8(a1)
     ff0:	6980                	ld	s0,16(a1)
     ff2:	6d84                	ld	s1,24(a1)
     ff4:	0205b903          	ld	s2,32(a1)
     ff8:	0285b983          	ld	s3,40(a1)
     ffc:	0305ba03          	ld	s4,48(a1)
    1000:	0385ba83          	ld	s5,56(a1)
    1004:	0405bb03          	ld	s6,64(a1)
    1008:	0485bb83          	ld	s7,72(a1)
    100c:	0505bc03          	ld	s8,80(a1)
    1010:	0585bc83          	ld	s9,88(a1)
    1014:	0605bd03          	ld	s10,96(a1)
    1018:	0685bd83          	ld	s11,104(a1)
    101c:	8082                	ret

000000000000101e <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
    101e:	1101                	addi	sp,sp,-32
    1020:	ec06                	sd	ra,24(sp)
    1022:	e822                	sd	s0,16(sp)
    1024:	e426                	sd	s1,8(sp)
    1026:	e04a                	sd	s2,0(sp)
    1028:	1000                	addi	s0,sp,32
    102a:	84aa                	mv	s1,a0
    102c:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
    102e:	00000097          	auipc	ra,0x0
    1032:	d1e080e7          	jalr	-738(ra) # d4c <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
    1036:	85ca                	mv	a1,s2
    1038:	8526                	mv	a0,s1
    103a:	00000097          	auipc	ra,0x0
    103e:	b0c080e7          	jalr	-1268(ra) # b46 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
    1042:	00000097          	auipc	ra,0x0
    1046:	274080e7          	jalr	628(ra) # 12b6 <exit>

000000000000104a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    104a:	1141                	addi	sp,sp,-16
    104c:	e422                	sd	s0,8(sp)
    104e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1050:	87aa                	mv	a5,a0
    1052:	0585                	addi	a1,a1,1
    1054:	0785                	addi	a5,a5,1
    1056:	fff5c703          	lbu	a4,-1(a1)
    105a:	fee78fa3          	sb	a4,-1(a5)
    105e:	fb75                	bnez	a4,1052 <strcpy+0x8>
        ;
    return os;
}
    1060:	6422                	ld	s0,8(sp)
    1062:	0141                	addi	sp,sp,16
    1064:	8082                	ret

0000000000001066 <strcmp>:

int strcmp(const char *p, const char *q)
{
    1066:	1141                	addi	sp,sp,-16
    1068:	e422                	sd	s0,8(sp)
    106a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
    106c:	00054783          	lbu	a5,0(a0)
    1070:	cb91                	beqz	a5,1084 <strcmp+0x1e>
    1072:	0005c703          	lbu	a4,0(a1)
    1076:	00f71763          	bne	a4,a5,1084 <strcmp+0x1e>
        p++, q++;
    107a:	0505                	addi	a0,a0,1
    107c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
    107e:	00054783          	lbu	a5,0(a0)
    1082:	fbe5                	bnez	a5,1072 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
    1084:	0005c503          	lbu	a0,0(a1)
}
    1088:	40a7853b          	subw	a0,a5,a0
    108c:	6422                	ld	s0,8(sp)
    108e:	0141                	addi	sp,sp,16
    1090:	8082                	ret

0000000000001092 <strlen>:

uint strlen(const char *s)
{
    1092:	1141                	addi	sp,sp,-16
    1094:	e422                	sd	s0,8(sp)
    1096:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    1098:	00054783          	lbu	a5,0(a0)
    109c:	cf91                	beqz	a5,10b8 <strlen+0x26>
    109e:	0505                	addi	a0,a0,1
    10a0:	87aa                	mv	a5,a0
    10a2:	86be                	mv	a3,a5
    10a4:	0785                	addi	a5,a5,1
    10a6:	fff7c703          	lbu	a4,-1(a5)
    10aa:	ff65                	bnez	a4,10a2 <strlen+0x10>
    10ac:	40a6853b          	subw	a0,a3,a0
    10b0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    10b2:	6422                	ld	s0,8(sp)
    10b4:	0141                	addi	sp,sp,16
    10b6:	8082                	ret
    for (n = 0; s[n]; n++)
    10b8:	4501                	li	a0,0
    10ba:	bfe5                	j	10b2 <strlen+0x20>

00000000000010bc <memset>:

void *
memset(void *dst, int c, uint n)
{
    10bc:	1141                	addi	sp,sp,-16
    10be:	e422                	sd	s0,8(sp)
    10c0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
    10c2:	ca19                	beqz	a2,10d8 <memset+0x1c>
    10c4:	87aa                	mv	a5,a0
    10c6:	1602                	slli	a2,a2,0x20
    10c8:	9201                	srli	a2,a2,0x20
    10ca:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
    10ce:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
    10d2:	0785                	addi	a5,a5,1
    10d4:	fee79de3          	bne	a5,a4,10ce <memset+0x12>
    }
    return dst;
}
    10d8:	6422                	ld	s0,8(sp)
    10da:	0141                	addi	sp,sp,16
    10dc:	8082                	ret

00000000000010de <strchr>:

char *
strchr(const char *s, char c)
{
    10de:	1141                	addi	sp,sp,-16
    10e0:	e422                	sd	s0,8(sp)
    10e2:	0800                	addi	s0,sp,16
    for (; *s; s++)
    10e4:	00054783          	lbu	a5,0(a0)
    10e8:	cb99                	beqz	a5,10fe <strchr+0x20>
        if (*s == c)
    10ea:	00f58763          	beq	a1,a5,10f8 <strchr+0x1a>
    for (; *s; s++)
    10ee:	0505                	addi	a0,a0,1
    10f0:	00054783          	lbu	a5,0(a0)
    10f4:	fbfd                	bnez	a5,10ea <strchr+0xc>
            return (char *)s;
    return 0;
    10f6:	4501                	li	a0,0
}
    10f8:	6422                	ld	s0,8(sp)
    10fa:	0141                	addi	sp,sp,16
    10fc:	8082                	ret
    return 0;
    10fe:	4501                	li	a0,0
    1100:	bfe5                	j	10f8 <strchr+0x1a>

0000000000001102 <gets>:

char *
gets(char *buf, int max)
{
    1102:	711d                	addi	sp,sp,-96
    1104:	ec86                	sd	ra,88(sp)
    1106:	e8a2                	sd	s0,80(sp)
    1108:	e4a6                	sd	s1,72(sp)
    110a:	e0ca                	sd	s2,64(sp)
    110c:	fc4e                	sd	s3,56(sp)
    110e:	f852                	sd	s4,48(sp)
    1110:	f456                	sd	s5,40(sp)
    1112:	f05a                	sd	s6,32(sp)
    1114:	ec5e                	sd	s7,24(sp)
    1116:	1080                	addi	s0,sp,96
    1118:	8baa                	mv	s7,a0
    111a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
    111c:	892a                	mv	s2,a0
    111e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    1120:	4aa9                	li	s5,10
    1122:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
    1124:	89a6                	mv	s3,s1
    1126:	2485                	addiw	s1,s1,1
    1128:	0344d863          	bge	s1,s4,1158 <gets+0x56>
        cc = read(0, &c, 1);
    112c:	4605                	li	a2,1
    112e:	faf40593          	addi	a1,s0,-81
    1132:	4501                	li	a0,0
    1134:	00000097          	auipc	ra,0x0
    1138:	19a080e7          	jalr	410(ra) # 12ce <read>
        if (cc < 1)
    113c:	00a05e63          	blez	a0,1158 <gets+0x56>
        buf[i++] = c;
    1140:	faf44783          	lbu	a5,-81(s0)
    1144:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    1148:	01578763          	beq	a5,s5,1156 <gets+0x54>
    114c:	0905                	addi	s2,s2,1
    114e:	fd679be3          	bne	a5,s6,1124 <gets+0x22>
    for (i = 0; i + 1 < max;)
    1152:	89a6                	mv	s3,s1
    1154:	a011                	j	1158 <gets+0x56>
    1156:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    1158:	99de                	add	s3,s3,s7
    115a:	00098023          	sb	zero,0(s3)
    return buf;
}
    115e:	855e                	mv	a0,s7
    1160:	60e6                	ld	ra,88(sp)
    1162:	6446                	ld	s0,80(sp)
    1164:	64a6                	ld	s1,72(sp)
    1166:	6906                	ld	s2,64(sp)
    1168:	79e2                	ld	s3,56(sp)
    116a:	7a42                	ld	s4,48(sp)
    116c:	7aa2                	ld	s5,40(sp)
    116e:	7b02                	ld	s6,32(sp)
    1170:	6be2                	ld	s7,24(sp)
    1172:	6125                	addi	sp,sp,96
    1174:	8082                	ret

0000000000001176 <stat>:

int stat(const char *n, struct stat *st)
{
    1176:	1101                	addi	sp,sp,-32
    1178:	ec06                	sd	ra,24(sp)
    117a:	e822                	sd	s0,16(sp)
    117c:	e426                	sd	s1,8(sp)
    117e:	e04a                	sd	s2,0(sp)
    1180:	1000                	addi	s0,sp,32
    1182:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    1184:	4581                	li	a1,0
    1186:	00000097          	auipc	ra,0x0
    118a:	170080e7          	jalr	368(ra) # 12f6 <open>
    if (fd < 0)
    118e:	02054563          	bltz	a0,11b8 <stat+0x42>
    1192:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    1194:	85ca                	mv	a1,s2
    1196:	00000097          	auipc	ra,0x0
    119a:	178080e7          	jalr	376(ra) # 130e <fstat>
    119e:	892a                	mv	s2,a0
    close(fd);
    11a0:	8526                	mv	a0,s1
    11a2:	00000097          	auipc	ra,0x0
    11a6:	13c080e7          	jalr	316(ra) # 12de <close>
    return r;
}
    11aa:	854a                	mv	a0,s2
    11ac:	60e2                	ld	ra,24(sp)
    11ae:	6442                	ld	s0,16(sp)
    11b0:	64a2                	ld	s1,8(sp)
    11b2:	6902                	ld	s2,0(sp)
    11b4:	6105                	addi	sp,sp,32
    11b6:	8082                	ret
        return -1;
    11b8:	597d                	li	s2,-1
    11ba:	bfc5                	j	11aa <stat+0x34>

00000000000011bc <atoi>:

int atoi(const char *s)
{
    11bc:	1141                	addi	sp,sp,-16
    11be:	e422                	sd	s0,8(sp)
    11c0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    11c2:	00054683          	lbu	a3,0(a0)
    11c6:	fd06879b          	addiw	a5,a3,-48
    11ca:	0ff7f793          	zext.b	a5,a5
    11ce:	4625                	li	a2,9
    11d0:	02f66863          	bltu	a2,a5,1200 <atoi+0x44>
    11d4:	872a                	mv	a4,a0
    n = 0;
    11d6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    11d8:	0705                	addi	a4,a4,1
    11da:	0025179b          	slliw	a5,a0,0x2
    11de:	9fa9                	addw	a5,a5,a0
    11e0:	0017979b          	slliw	a5,a5,0x1
    11e4:	9fb5                	addw	a5,a5,a3
    11e6:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    11ea:	00074683          	lbu	a3,0(a4)
    11ee:	fd06879b          	addiw	a5,a3,-48
    11f2:	0ff7f793          	zext.b	a5,a5
    11f6:	fef671e3          	bgeu	a2,a5,11d8 <atoi+0x1c>
    return n;
}
    11fa:	6422                	ld	s0,8(sp)
    11fc:	0141                	addi	sp,sp,16
    11fe:	8082                	ret
    n = 0;
    1200:	4501                	li	a0,0
    1202:	bfe5                	j	11fa <atoi+0x3e>

0000000000001204 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    1204:	1141                	addi	sp,sp,-16
    1206:	e422                	sd	s0,8(sp)
    1208:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    120a:	02b57463          	bgeu	a0,a1,1232 <memmove+0x2e>
    {
        while (n-- > 0)
    120e:	00c05f63          	blez	a2,122c <memmove+0x28>
    1212:	1602                	slli	a2,a2,0x20
    1214:	9201                	srli	a2,a2,0x20
    1216:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    121a:	872a                	mv	a4,a0
            *dst++ = *src++;
    121c:	0585                	addi	a1,a1,1
    121e:	0705                	addi	a4,a4,1
    1220:	fff5c683          	lbu	a3,-1(a1)
    1224:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    1228:	fee79ae3          	bne	a5,a4,121c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    122c:	6422                	ld	s0,8(sp)
    122e:	0141                	addi	sp,sp,16
    1230:	8082                	ret
        dst += n;
    1232:	00c50733          	add	a4,a0,a2
        src += n;
    1236:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1238:	fec05ae3          	blez	a2,122c <memmove+0x28>
    123c:	fff6079b          	addiw	a5,a2,-1
    1240:	1782                	slli	a5,a5,0x20
    1242:	9381                	srli	a5,a5,0x20
    1244:	fff7c793          	not	a5,a5
    1248:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    124a:	15fd                	addi	a1,a1,-1
    124c:	177d                	addi	a4,a4,-1
    124e:	0005c683          	lbu	a3,0(a1)
    1252:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    1256:	fee79ae3          	bne	a5,a4,124a <memmove+0x46>
    125a:	bfc9                	j	122c <memmove+0x28>

000000000000125c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    125c:	1141                	addi	sp,sp,-16
    125e:	e422                	sd	s0,8(sp)
    1260:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    1262:	ca05                	beqz	a2,1292 <memcmp+0x36>
    1264:	fff6069b          	addiw	a3,a2,-1
    1268:	1682                	slli	a3,a3,0x20
    126a:	9281                	srli	a3,a3,0x20
    126c:	0685                	addi	a3,a3,1
    126e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    1270:	00054783          	lbu	a5,0(a0)
    1274:	0005c703          	lbu	a4,0(a1)
    1278:	00e79863          	bne	a5,a4,1288 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    127c:	0505                	addi	a0,a0,1
        p2++;
    127e:	0585                	addi	a1,a1,1
    while (n-- > 0)
    1280:	fed518e3          	bne	a0,a3,1270 <memcmp+0x14>
    }
    return 0;
    1284:	4501                	li	a0,0
    1286:	a019                	j	128c <memcmp+0x30>
            return *p1 - *p2;
    1288:	40e7853b          	subw	a0,a5,a4
}
    128c:	6422                	ld	s0,8(sp)
    128e:	0141                	addi	sp,sp,16
    1290:	8082                	ret
    return 0;
    1292:	4501                	li	a0,0
    1294:	bfe5                	j	128c <memcmp+0x30>

0000000000001296 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1296:	1141                	addi	sp,sp,-16
    1298:	e406                	sd	ra,8(sp)
    129a:	e022                	sd	s0,0(sp)
    129c:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    129e:	00000097          	auipc	ra,0x0
    12a2:	f66080e7          	jalr	-154(ra) # 1204 <memmove>
}
    12a6:	60a2                	ld	ra,8(sp)
    12a8:	6402                	ld	s0,0(sp)
    12aa:	0141                	addi	sp,sp,16
    12ac:	8082                	ret

00000000000012ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    12ae:	4885                	li	a7,1
 ecall
    12b0:	00000073          	ecall
 ret
    12b4:	8082                	ret

00000000000012b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
    12b6:	4889                	li	a7,2
 ecall
    12b8:	00000073          	ecall
 ret
    12bc:	8082                	ret

00000000000012be <wait>:
.global wait
wait:
 li a7, SYS_wait
    12be:	488d                	li	a7,3
 ecall
    12c0:	00000073          	ecall
 ret
    12c4:	8082                	ret

00000000000012c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    12c6:	4891                	li	a7,4
 ecall
    12c8:	00000073          	ecall
 ret
    12cc:	8082                	ret

00000000000012ce <read>:
.global read
read:
 li a7, SYS_read
    12ce:	4895                	li	a7,5
 ecall
    12d0:	00000073          	ecall
 ret
    12d4:	8082                	ret

00000000000012d6 <write>:
.global write
write:
 li a7, SYS_write
    12d6:	48c1                	li	a7,16
 ecall
    12d8:	00000073          	ecall
 ret
    12dc:	8082                	ret

00000000000012de <close>:
.global close
close:
 li a7, SYS_close
    12de:	48d5                	li	a7,21
 ecall
    12e0:	00000073          	ecall
 ret
    12e4:	8082                	ret

00000000000012e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
    12e6:	4899                	li	a7,6
 ecall
    12e8:	00000073          	ecall
 ret
    12ec:	8082                	ret

00000000000012ee <exec>:
.global exec
exec:
 li a7, SYS_exec
    12ee:	489d                	li	a7,7
 ecall
    12f0:	00000073          	ecall
 ret
    12f4:	8082                	ret

00000000000012f6 <open>:
.global open
open:
 li a7, SYS_open
    12f6:	48bd                	li	a7,15
 ecall
    12f8:	00000073          	ecall
 ret
    12fc:	8082                	ret

00000000000012fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    12fe:	48c5                	li	a7,17
 ecall
    1300:	00000073          	ecall
 ret
    1304:	8082                	ret

0000000000001306 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1306:	48c9                	li	a7,18
 ecall
    1308:	00000073          	ecall
 ret
    130c:	8082                	ret

000000000000130e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    130e:	48a1                	li	a7,8
 ecall
    1310:	00000073          	ecall
 ret
    1314:	8082                	ret

0000000000001316 <link>:
.global link
link:
 li a7, SYS_link
    1316:	48cd                	li	a7,19
 ecall
    1318:	00000073          	ecall
 ret
    131c:	8082                	ret

000000000000131e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    131e:	48d1                	li	a7,20
 ecall
    1320:	00000073          	ecall
 ret
    1324:	8082                	ret

0000000000001326 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1326:	48a5                	li	a7,9
 ecall
    1328:	00000073          	ecall
 ret
    132c:	8082                	ret

000000000000132e <dup>:
.global dup
dup:
 li a7, SYS_dup
    132e:	48a9                	li	a7,10
 ecall
    1330:	00000073          	ecall
 ret
    1334:	8082                	ret

0000000000001336 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1336:	48ad                	li	a7,11
 ecall
    1338:	00000073          	ecall
 ret
    133c:	8082                	ret

000000000000133e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    133e:	48b1                	li	a7,12
 ecall
    1340:	00000073          	ecall
 ret
    1344:	8082                	ret

0000000000001346 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1346:	48b5                	li	a7,13
 ecall
    1348:	00000073          	ecall
 ret
    134c:	8082                	ret

000000000000134e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    134e:	48b9                	li	a7,14
 ecall
    1350:	00000073          	ecall
 ret
    1354:	8082                	ret

0000000000001356 <ps>:
.global ps
ps:
 li a7, SYS_ps
    1356:	48d9                	li	a7,22
 ecall
    1358:	00000073          	ecall
 ret
    135c:	8082                	ret

000000000000135e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    135e:	48dd                	li	a7,23
 ecall
    1360:	00000073          	ecall
 ret
    1364:	8082                	ret

0000000000001366 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    1366:	48e1                	li	a7,24
 ecall
    1368:	00000073          	ecall
 ret
    136c:	8082                	ret

000000000000136e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    136e:	1101                	addi	sp,sp,-32
    1370:	ec06                	sd	ra,24(sp)
    1372:	e822                	sd	s0,16(sp)
    1374:	1000                	addi	s0,sp,32
    1376:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    137a:	4605                	li	a2,1
    137c:	fef40593          	addi	a1,s0,-17
    1380:	00000097          	auipc	ra,0x0
    1384:	f56080e7          	jalr	-170(ra) # 12d6 <write>
}
    1388:	60e2                	ld	ra,24(sp)
    138a:	6442                	ld	s0,16(sp)
    138c:	6105                	addi	sp,sp,32
    138e:	8082                	ret

0000000000001390 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1390:	7139                	addi	sp,sp,-64
    1392:	fc06                	sd	ra,56(sp)
    1394:	f822                	sd	s0,48(sp)
    1396:	f426                	sd	s1,40(sp)
    1398:	f04a                	sd	s2,32(sp)
    139a:	ec4e                	sd	s3,24(sp)
    139c:	0080                	addi	s0,sp,64
    139e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13a0:	c299                	beqz	a3,13a6 <printint+0x16>
    13a2:	0805c963          	bltz	a1,1434 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    13a6:	2581                	sext.w	a1,a1
  neg = 0;
    13a8:	4881                	li	a7,0
    13aa:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    13ae:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    13b0:	2601                	sext.w	a2,a2
    13b2:	00000517          	auipc	a0,0x0
    13b6:	63650513          	addi	a0,a0,1590 # 19e8 <digits>
    13ba:	883a                	mv	a6,a4
    13bc:	2705                	addiw	a4,a4,1
    13be:	02c5f7bb          	remuw	a5,a1,a2
    13c2:	1782                	slli	a5,a5,0x20
    13c4:	9381                	srli	a5,a5,0x20
    13c6:	97aa                	add	a5,a5,a0
    13c8:	0007c783          	lbu	a5,0(a5)
    13cc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    13d0:	0005879b          	sext.w	a5,a1
    13d4:	02c5d5bb          	divuw	a1,a1,a2
    13d8:	0685                	addi	a3,a3,1
    13da:	fec7f0e3          	bgeu	a5,a2,13ba <printint+0x2a>
  if(neg)
    13de:	00088c63          	beqz	a7,13f6 <printint+0x66>
    buf[i++] = '-';
    13e2:	fd070793          	addi	a5,a4,-48
    13e6:	00878733          	add	a4,a5,s0
    13ea:	02d00793          	li	a5,45
    13ee:	fef70823          	sb	a5,-16(a4)
    13f2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    13f6:	02e05863          	blez	a4,1426 <printint+0x96>
    13fa:	fc040793          	addi	a5,s0,-64
    13fe:	00e78933          	add	s2,a5,a4
    1402:	fff78993          	addi	s3,a5,-1
    1406:	99ba                	add	s3,s3,a4
    1408:	377d                	addiw	a4,a4,-1
    140a:	1702                	slli	a4,a4,0x20
    140c:	9301                	srli	a4,a4,0x20
    140e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1412:	fff94583          	lbu	a1,-1(s2)
    1416:	8526                	mv	a0,s1
    1418:	00000097          	auipc	ra,0x0
    141c:	f56080e7          	jalr	-170(ra) # 136e <putc>
  while(--i >= 0)
    1420:	197d                	addi	s2,s2,-1
    1422:	ff3918e3          	bne	s2,s3,1412 <printint+0x82>
}
    1426:	70e2                	ld	ra,56(sp)
    1428:	7442                	ld	s0,48(sp)
    142a:	74a2                	ld	s1,40(sp)
    142c:	7902                	ld	s2,32(sp)
    142e:	69e2                	ld	s3,24(sp)
    1430:	6121                	addi	sp,sp,64
    1432:	8082                	ret
    x = -xx;
    1434:	40b005bb          	negw	a1,a1
    neg = 1;
    1438:	4885                	li	a7,1
    x = -xx;
    143a:	bf85                	j	13aa <printint+0x1a>

000000000000143c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    143c:	715d                	addi	sp,sp,-80
    143e:	e486                	sd	ra,72(sp)
    1440:	e0a2                	sd	s0,64(sp)
    1442:	fc26                	sd	s1,56(sp)
    1444:	f84a                	sd	s2,48(sp)
    1446:	f44e                	sd	s3,40(sp)
    1448:	f052                	sd	s4,32(sp)
    144a:	ec56                	sd	s5,24(sp)
    144c:	e85a                	sd	s6,16(sp)
    144e:	e45e                	sd	s7,8(sp)
    1450:	e062                	sd	s8,0(sp)
    1452:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1454:	0005c903          	lbu	s2,0(a1)
    1458:	18090c63          	beqz	s2,15f0 <vprintf+0x1b4>
    145c:	8aaa                	mv	s5,a0
    145e:	8bb2                	mv	s7,a2
    1460:	00158493          	addi	s1,a1,1
  state = 0;
    1464:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1466:	02500a13          	li	s4,37
    146a:	4b55                	li	s6,21
    146c:	a839                	j	148a <vprintf+0x4e>
        putc(fd, c);
    146e:	85ca                	mv	a1,s2
    1470:	8556                	mv	a0,s5
    1472:	00000097          	auipc	ra,0x0
    1476:	efc080e7          	jalr	-260(ra) # 136e <putc>
    147a:	a019                	j	1480 <vprintf+0x44>
    } else if(state == '%'){
    147c:	01498d63          	beq	s3,s4,1496 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    1480:	0485                	addi	s1,s1,1
    1482:	fff4c903          	lbu	s2,-1(s1)
    1486:	16090563          	beqz	s2,15f0 <vprintf+0x1b4>
    if(state == 0){
    148a:	fe0999e3          	bnez	s3,147c <vprintf+0x40>
      if(c == '%'){
    148e:	ff4910e3          	bne	s2,s4,146e <vprintf+0x32>
        state = '%';
    1492:	89d2                	mv	s3,s4
    1494:	b7f5                	j	1480 <vprintf+0x44>
      if(c == 'd'){
    1496:	13490263          	beq	s2,s4,15ba <vprintf+0x17e>
    149a:	f9d9079b          	addiw	a5,s2,-99
    149e:	0ff7f793          	zext.b	a5,a5
    14a2:	12fb6563          	bltu	s6,a5,15cc <vprintf+0x190>
    14a6:	f9d9079b          	addiw	a5,s2,-99
    14aa:	0ff7f713          	zext.b	a4,a5
    14ae:	10eb6f63          	bltu	s6,a4,15cc <vprintf+0x190>
    14b2:	00271793          	slli	a5,a4,0x2
    14b6:	00000717          	auipc	a4,0x0
    14ba:	4da70713          	addi	a4,a4,1242 # 1990 <malloc+0x2a2>
    14be:	97ba                	add	a5,a5,a4
    14c0:	439c                	lw	a5,0(a5)
    14c2:	97ba                	add	a5,a5,a4
    14c4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    14c6:	008b8913          	addi	s2,s7,8
    14ca:	4685                	li	a3,1
    14cc:	4629                	li	a2,10
    14ce:	000ba583          	lw	a1,0(s7)
    14d2:	8556                	mv	a0,s5
    14d4:	00000097          	auipc	ra,0x0
    14d8:	ebc080e7          	jalr	-324(ra) # 1390 <printint>
    14dc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14de:	4981                	li	s3,0
    14e0:	b745                	j	1480 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    14e2:	008b8913          	addi	s2,s7,8
    14e6:	4681                	li	a3,0
    14e8:	4629                	li	a2,10
    14ea:	000ba583          	lw	a1,0(s7)
    14ee:	8556                	mv	a0,s5
    14f0:	00000097          	auipc	ra,0x0
    14f4:	ea0080e7          	jalr	-352(ra) # 1390 <printint>
    14f8:	8bca                	mv	s7,s2
      state = 0;
    14fa:	4981                	li	s3,0
    14fc:	b751                	j	1480 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    14fe:	008b8913          	addi	s2,s7,8
    1502:	4681                	li	a3,0
    1504:	4641                	li	a2,16
    1506:	000ba583          	lw	a1,0(s7)
    150a:	8556                	mv	a0,s5
    150c:	00000097          	auipc	ra,0x0
    1510:	e84080e7          	jalr	-380(ra) # 1390 <printint>
    1514:	8bca                	mv	s7,s2
      state = 0;
    1516:	4981                	li	s3,0
    1518:	b7a5                	j	1480 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    151a:	008b8c13          	addi	s8,s7,8
    151e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1522:	03000593          	li	a1,48
    1526:	8556                	mv	a0,s5
    1528:	00000097          	auipc	ra,0x0
    152c:	e46080e7          	jalr	-442(ra) # 136e <putc>
  putc(fd, 'x');
    1530:	07800593          	li	a1,120
    1534:	8556                	mv	a0,s5
    1536:	00000097          	auipc	ra,0x0
    153a:	e38080e7          	jalr	-456(ra) # 136e <putc>
    153e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1540:	00000b97          	auipc	s7,0x0
    1544:	4a8b8b93          	addi	s7,s7,1192 # 19e8 <digits>
    1548:	03c9d793          	srli	a5,s3,0x3c
    154c:	97de                	add	a5,a5,s7
    154e:	0007c583          	lbu	a1,0(a5)
    1552:	8556                	mv	a0,s5
    1554:	00000097          	auipc	ra,0x0
    1558:	e1a080e7          	jalr	-486(ra) # 136e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    155c:	0992                	slli	s3,s3,0x4
    155e:	397d                	addiw	s2,s2,-1
    1560:	fe0914e3          	bnez	s2,1548 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1564:	8be2                	mv	s7,s8
      state = 0;
    1566:	4981                	li	s3,0
    1568:	bf21                	j	1480 <vprintf+0x44>
        s = va_arg(ap, char*);
    156a:	008b8993          	addi	s3,s7,8
    156e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    1572:	02090163          	beqz	s2,1594 <vprintf+0x158>
        while(*s != 0){
    1576:	00094583          	lbu	a1,0(s2)
    157a:	c9a5                	beqz	a1,15ea <vprintf+0x1ae>
          putc(fd, *s);
    157c:	8556                	mv	a0,s5
    157e:	00000097          	auipc	ra,0x0
    1582:	df0080e7          	jalr	-528(ra) # 136e <putc>
          s++;
    1586:	0905                	addi	s2,s2,1
        while(*s != 0){
    1588:	00094583          	lbu	a1,0(s2)
    158c:	f9e5                	bnez	a1,157c <vprintf+0x140>
        s = va_arg(ap, char*);
    158e:	8bce                	mv	s7,s3
      state = 0;
    1590:	4981                	li	s3,0
    1592:	b5fd                	j	1480 <vprintf+0x44>
          s = "(null)";
    1594:	00000917          	auipc	s2,0x0
    1598:	3f490913          	addi	s2,s2,1012 # 1988 <malloc+0x29a>
        while(*s != 0){
    159c:	02800593          	li	a1,40
    15a0:	bff1                	j	157c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    15a2:	008b8913          	addi	s2,s7,8
    15a6:	000bc583          	lbu	a1,0(s7)
    15aa:	8556                	mv	a0,s5
    15ac:	00000097          	auipc	ra,0x0
    15b0:	dc2080e7          	jalr	-574(ra) # 136e <putc>
    15b4:	8bca                	mv	s7,s2
      state = 0;
    15b6:	4981                	li	s3,0
    15b8:	b5e1                	j	1480 <vprintf+0x44>
        putc(fd, c);
    15ba:	02500593          	li	a1,37
    15be:	8556                	mv	a0,s5
    15c0:	00000097          	auipc	ra,0x0
    15c4:	dae080e7          	jalr	-594(ra) # 136e <putc>
      state = 0;
    15c8:	4981                	li	s3,0
    15ca:	bd5d                	j	1480 <vprintf+0x44>
        putc(fd, '%');
    15cc:	02500593          	li	a1,37
    15d0:	8556                	mv	a0,s5
    15d2:	00000097          	auipc	ra,0x0
    15d6:	d9c080e7          	jalr	-612(ra) # 136e <putc>
        putc(fd, c);
    15da:	85ca                	mv	a1,s2
    15dc:	8556                	mv	a0,s5
    15de:	00000097          	auipc	ra,0x0
    15e2:	d90080e7          	jalr	-624(ra) # 136e <putc>
      state = 0;
    15e6:	4981                	li	s3,0
    15e8:	bd61                	j	1480 <vprintf+0x44>
        s = va_arg(ap, char*);
    15ea:	8bce                	mv	s7,s3
      state = 0;
    15ec:	4981                	li	s3,0
    15ee:	bd49                	j	1480 <vprintf+0x44>
    }
  }
}
    15f0:	60a6                	ld	ra,72(sp)
    15f2:	6406                	ld	s0,64(sp)
    15f4:	74e2                	ld	s1,56(sp)
    15f6:	7942                	ld	s2,48(sp)
    15f8:	79a2                	ld	s3,40(sp)
    15fa:	7a02                	ld	s4,32(sp)
    15fc:	6ae2                	ld	s5,24(sp)
    15fe:	6b42                	ld	s6,16(sp)
    1600:	6ba2                	ld	s7,8(sp)
    1602:	6c02                	ld	s8,0(sp)
    1604:	6161                	addi	sp,sp,80
    1606:	8082                	ret

0000000000001608 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1608:	715d                	addi	sp,sp,-80
    160a:	ec06                	sd	ra,24(sp)
    160c:	e822                	sd	s0,16(sp)
    160e:	1000                	addi	s0,sp,32
    1610:	e010                	sd	a2,0(s0)
    1612:	e414                	sd	a3,8(s0)
    1614:	e818                	sd	a4,16(s0)
    1616:	ec1c                	sd	a5,24(s0)
    1618:	03043023          	sd	a6,32(s0)
    161c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1620:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1624:	8622                	mv	a2,s0
    1626:	00000097          	auipc	ra,0x0
    162a:	e16080e7          	jalr	-490(ra) # 143c <vprintf>
}
    162e:	60e2                	ld	ra,24(sp)
    1630:	6442                	ld	s0,16(sp)
    1632:	6161                	addi	sp,sp,80
    1634:	8082                	ret

0000000000001636 <printf>:

void
printf(const char *fmt, ...)
{
    1636:	711d                	addi	sp,sp,-96
    1638:	ec06                	sd	ra,24(sp)
    163a:	e822                	sd	s0,16(sp)
    163c:	1000                	addi	s0,sp,32
    163e:	e40c                	sd	a1,8(s0)
    1640:	e810                	sd	a2,16(s0)
    1642:	ec14                	sd	a3,24(s0)
    1644:	f018                	sd	a4,32(s0)
    1646:	f41c                	sd	a5,40(s0)
    1648:	03043823          	sd	a6,48(s0)
    164c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1650:	00840613          	addi	a2,s0,8
    1654:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1658:	85aa                	mv	a1,a0
    165a:	4505                	li	a0,1
    165c:	00000097          	auipc	ra,0x0
    1660:	de0080e7          	jalr	-544(ra) # 143c <vprintf>
}
    1664:	60e2                	ld	ra,24(sp)
    1666:	6442                	ld	s0,16(sp)
    1668:	6125                	addi	sp,sp,96
    166a:	8082                	ret

000000000000166c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    166c:	1141                	addi	sp,sp,-16
    166e:	e422                	sd	s0,8(sp)
    1670:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    1672:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1676:	00001797          	auipc	a5,0x1
    167a:	9b27b783          	ld	a5,-1614(a5) # 2028 <freep>
    167e:	a02d                	j	16a8 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    1680:	4618                	lw	a4,8(a2)
    1682:	9f2d                	addw	a4,a4,a1
    1684:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    1688:	6398                	ld	a4,0(a5)
    168a:	6310                	ld	a2,0(a4)
    168c:	a83d                	j	16ca <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    168e:	ff852703          	lw	a4,-8(a0)
    1692:	9f31                	addw	a4,a4,a2
    1694:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    1696:	ff053683          	ld	a3,-16(a0)
    169a:	a091                	j	16de <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    169c:	6398                	ld	a4,0(a5)
    169e:	00e7e463          	bltu	a5,a4,16a6 <free+0x3a>
    16a2:	00e6ea63          	bltu	a3,a4,16b6 <free+0x4a>
{
    16a6:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a8:	fed7fae3          	bgeu	a5,a3,169c <free+0x30>
    16ac:	6398                	ld	a4,0(a5)
    16ae:	00e6e463          	bltu	a3,a4,16b6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16b2:	fee7eae3          	bltu	a5,a4,16a6 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    16b6:	ff852583          	lw	a1,-8(a0)
    16ba:	6390                	ld	a2,0(a5)
    16bc:	02059813          	slli	a6,a1,0x20
    16c0:	01c85713          	srli	a4,a6,0x1c
    16c4:	9736                	add	a4,a4,a3
    16c6:	fae60de3          	beq	a2,a4,1680 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    16ca:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    16ce:	4790                	lw	a2,8(a5)
    16d0:	02061593          	slli	a1,a2,0x20
    16d4:	01c5d713          	srli	a4,a1,0x1c
    16d8:	973e                	add	a4,a4,a5
    16da:	fae68ae3          	beq	a3,a4,168e <free+0x22>
        p->s.ptr = bp->s.ptr;
    16de:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    16e0:	00001717          	auipc	a4,0x1
    16e4:	94f73423          	sd	a5,-1720(a4) # 2028 <freep>
}
    16e8:	6422                	ld	s0,8(sp)
    16ea:	0141                	addi	sp,sp,16
    16ec:	8082                	ret

00000000000016ee <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    16ee:	7139                	addi	sp,sp,-64
    16f0:	fc06                	sd	ra,56(sp)
    16f2:	f822                	sd	s0,48(sp)
    16f4:	f426                	sd	s1,40(sp)
    16f6:	f04a                	sd	s2,32(sp)
    16f8:	ec4e                	sd	s3,24(sp)
    16fa:	e852                	sd	s4,16(sp)
    16fc:	e456                	sd	s5,8(sp)
    16fe:	e05a                	sd	s6,0(sp)
    1700:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    1702:	02051493          	slli	s1,a0,0x20
    1706:	9081                	srli	s1,s1,0x20
    1708:	04bd                	addi	s1,s1,15
    170a:	8091                	srli	s1,s1,0x4
    170c:	0014899b          	addiw	s3,s1,1
    1710:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    1712:	00001517          	auipc	a0,0x1
    1716:	91653503          	ld	a0,-1770(a0) # 2028 <freep>
    171a:	c515                	beqz	a0,1746 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    171c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    171e:	4798                	lw	a4,8(a5)
    1720:	02977f63          	bgeu	a4,s1,175e <malloc+0x70>
    if (nu < 4096)
    1724:	8a4e                	mv	s4,s3
    1726:	0009871b          	sext.w	a4,s3
    172a:	6685                	lui	a3,0x1
    172c:	00d77363          	bgeu	a4,a3,1732 <malloc+0x44>
    1730:	6a05                	lui	s4,0x1
    1732:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    1736:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    173a:	00001917          	auipc	s2,0x1
    173e:	8ee90913          	addi	s2,s2,-1810 # 2028 <freep>
    if (p == (char *)-1)
    1742:	5afd                	li	s5,-1
    1744:	a895                	j	17b8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    1746:	00001797          	auipc	a5,0x1
    174a:	9e278793          	addi	a5,a5,-1566 # 2128 <base>
    174e:	00001717          	auipc	a4,0x1
    1752:	8cf73d23          	sd	a5,-1830(a4) # 2028 <freep>
    1756:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    1758:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    175c:	b7e1                	j	1724 <malloc+0x36>
            if (p->s.size == nunits)
    175e:	02e48c63          	beq	s1,a4,1796 <malloc+0xa8>
                p->s.size -= nunits;
    1762:	4137073b          	subw	a4,a4,s3
    1766:	c798                	sw	a4,8(a5)
                p += p->s.size;
    1768:	02071693          	slli	a3,a4,0x20
    176c:	01c6d713          	srli	a4,a3,0x1c
    1770:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    1772:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    1776:	00001717          	auipc	a4,0x1
    177a:	8aa73923          	sd	a0,-1870(a4) # 2028 <freep>
            return (void *)(p + 1);
    177e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    1782:	70e2                	ld	ra,56(sp)
    1784:	7442                	ld	s0,48(sp)
    1786:	74a2                	ld	s1,40(sp)
    1788:	7902                	ld	s2,32(sp)
    178a:	69e2                	ld	s3,24(sp)
    178c:	6a42                	ld	s4,16(sp)
    178e:	6aa2                	ld	s5,8(sp)
    1790:	6b02                	ld	s6,0(sp)
    1792:	6121                	addi	sp,sp,64
    1794:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    1796:	6398                	ld	a4,0(a5)
    1798:	e118                	sd	a4,0(a0)
    179a:	bff1                	j	1776 <malloc+0x88>
    hp->s.size = nu;
    179c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    17a0:	0541                	addi	a0,a0,16
    17a2:	00000097          	auipc	ra,0x0
    17a6:	eca080e7          	jalr	-310(ra) # 166c <free>
    return freep;
    17aa:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    17ae:	d971                	beqz	a0,1782 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    17b0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    17b2:	4798                	lw	a4,8(a5)
    17b4:	fa9775e3          	bgeu	a4,s1,175e <malloc+0x70>
        if (p == freep)
    17b8:	00093703          	ld	a4,0(s2)
    17bc:	853e                	mv	a0,a5
    17be:	fef719e3          	bne	a4,a5,17b0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    17c2:	8552                	mv	a0,s4
    17c4:	00000097          	auipc	ra,0x0
    17c8:	b7a080e7          	jalr	-1158(ra) # 133e <sbrk>
    if (p == (char *)-1)
    17cc:	fd5518e3          	bne	a0,s5,179c <malloc+0xae>
                return 0;
    17d0:	4501                	li	a0,0
    17d2:	bf45                	j	1782 <malloc+0x94>
