
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
      16:	5fe58593          	addi	a1,a1,1534 # 1610 <malloc+0xf2>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	0ea080e7          	jalr	234(ra) # 1106 <write>
    memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	ec2080e7          	jalr	-318(ra) # eec <memset>
    gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	efc080e7          	jalr	-260(ra) # f32 <gets>
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
      64:	5b858593          	addi	a1,a1,1464 # 1618 <malloc+0xfa>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	3ce080e7          	jalr	974(ra) # 1438 <fprintf>
    exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	072080e7          	jalr	114(ra) # 10e6 <exit>

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
      88:	05a080e7          	jalr	90(ra) # 10de <fork>
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
      9e:	58650513          	addi	a0,a0,1414 # 1620 <malloc+0x102>
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
      c6:	00001717          	auipc	a4,0x1
      ca:	66e70713          	addi	a4,a4,1646 # 1734 <malloc+0x216>
      ce:	97ba                	add	a5,a5,a4
      d0:	439c                	lw	a5,0(a5)
      d2:	97ba                	add	a5,a5,a4
      d4:	8782                	jr	a5
        exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	00e080e7          	jalr	14(ra) # 10e6 <exit>
        panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	54850513          	addi	a0,a0,1352 # 1628 <malloc+0x10a>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6e080e7          	jalr	-146(ra) # 56 <panic>
        if (ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x74>
        exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	addi	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	026080e7          	jalr	38(ra) # 111e <exec>
        fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	52e58593          	addi	a1,a1,1326 # 1630 <malloc+0x112>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	32c080e7          	jalr	812(ra) # 1438 <fprintf>
    exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	fd0080e7          	jalr	-48(ra) # 10e6 <exit>
            exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	fc6080e7          	jalr	-58(ra) # 10e6 <exit>
        close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	fe4080e7          	jalr	-28(ra) # 110e <close>
        if (open(rcmd->file, rcmd->mode) < 0)
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	ff0080e7          	jalr	-16(ra) # 1126 <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa2>
        runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f66080e7          	jalr	-154(ra) # aa <runcmd>
            fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	4f258593          	addi	a1,a1,1266 # 1640 <malloc+0x122>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	2e0080e7          	jalr	736(ra) # 1438 <fprintf>
            exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	f84080e7          	jalr	-124(ra) # 10e6 <exit>
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
     184:	f6e080e7          	jalr	-146(ra) # 10ee <wait>
        runcmd(lcmd->right);
     188:	6888                	ld	a0,16(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f20080e7          	jalr	-224(ra) # aa <runcmd>
        if (pipe(p) < 0)
     192:	fd840513          	addi	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	f60080e7          	jalr	-160(ra) # 10f6 <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13a>
        if (fork1() == 0)
     1a2:	00000097          	auipc	ra,0x0
     1a6:	eda080e7          	jalr	-294(ra) # 7c <fork1>
     1aa:	e529                	bnez	a0,1f4 <runcmd+0x14a>
            close(1);
     1ac:	4505                	li	a0,1
     1ae:	00001097          	auipc	ra,0x1
     1b2:	f60080e7          	jalr	-160(ra) # 110e <close>
            dup(p[1]);
     1b6:	fdc42503          	lw	a0,-36(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	fa4080e7          	jalr	-92(ra) # 115e <dup>
            close(p[0]);
     1c2:	fd842503          	lw	a0,-40(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	f48080e7          	jalr	-184(ra) # 110e <close>
            close(p[1]);
     1ce:	fdc42503          	lw	a0,-36(s0)
     1d2:	00001097          	auipc	ra,0x1
     1d6:	f3c080e7          	jalr	-196(ra) # 110e <close>
            runcmd(pcmd->left);
     1da:	6488                	ld	a0,8(s1)
     1dc:	00000097          	auipc	ra,0x0
     1e0:	ece080e7          	jalr	-306(ra) # aa <runcmd>
            panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	46c50513          	addi	a0,a0,1132 # 1650 <malloc+0x132>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e6a080e7          	jalr	-406(ra) # 56 <panic>
        if (fork1() == 0)
     1f4:	00000097          	auipc	ra,0x0
     1f8:	e88080e7          	jalr	-376(ra) # 7c <fork1>
     1fc:	ed05                	bnez	a0,234 <runcmd+0x18a>
            close(0);
     1fe:	00001097          	auipc	ra,0x1
     202:	f10080e7          	jalr	-240(ra) # 110e <close>
            dup(p[0]);
     206:	fd842503          	lw	a0,-40(s0)
     20a:	00001097          	auipc	ra,0x1
     20e:	f54080e7          	jalr	-172(ra) # 115e <dup>
            close(p[0]);
     212:	fd842503          	lw	a0,-40(s0)
     216:	00001097          	auipc	ra,0x1
     21a:	ef8080e7          	jalr	-264(ra) # 110e <close>
            close(p[1]);
     21e:	fdc42503          	lw	a0,-36(s0)
     222:	00001097          	auipc	ra,0x1
     226:	eec080e7          	jalr	-276(ra) # 110e <close>
            runcmd(pcmd->right);
     22a:	6888                	ld	a0,16(s1)
     22c:	00000097          	auipc	ra,0x0
     230:	e7e080e7          	jalr	-386(ra) # aa <runcmd>
        close(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	ed6080e7          	jalr	-298(ra) # 110e <close>
        close(p[1]);
     240:	fdc42503          	lw	a0,-36(s0)
     244:	00001097          	auipc	ra,0x1
     248:	eca080e7          	jalr	-310(ra) # 110e <close>
        wait(0);
     24c:	4501                	li	a0,0
     24e:	00001097          	auipc	ra,0x1
     252:	ea0080e7          	jalr	-352(ra) # 10ee <wait>
        wait(0);
     256:	4501                	li	a0,0
     258:	00001097          	auipc	ra,0x1
     25c:	e96080e7          	jalr	-362(ra) # 10ee <wait>
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
     28a:	298080e7          	jalr	664(ra) # 151e <malloc>
     28e:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	c56080e7          	jalr	-938(ra) # eec <memset>
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
     2d4:	24e080e7          	jalr	590(ra) # 151e <malloc>
     2d8:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	c0c080e7          	jalr	-1012(ra) # eec <memset>
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
     32e:	1f4080e7          	jalr	500(ra) # 151e <malloc>
     332:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	bb4080e7          	jalr	-1100(ra) # eec <memset>
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
     374:	1ae080e7          	jalr	430(ra) # 151e <malloc>
     378:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	b6e080e7          	jalr	-1170(ra) # eec <memset>
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
     3b6:	16c080e7          	jalr	364(ra) # 151e <malloc>
     3ba:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	b2c080e7          	jalr	-1236(ra) # eec <memset>
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
     412:	b00080e7          	jalr	-1280(ra) # f0e <strchr>
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
     478:	a9a080e7          	jalr	-1382(ra) # f0e <strchr>
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
     4ec:	a26080e7          	jalr	-1498(ra) # f0e <strchr>
     4f0:	e50d                	bnez	a0,51a <gettoken+0x13c>
     4f2:	0004c583          	lbu	a1,0(s1)
     4f6:	8556                	mv	a0,s5
     4f8:	00001097          	auipc	ra,0x1
     4fc:	a16080e7          	jalr	-1514(ra) # f0e <strchr>
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
     55a:	9b8080e7          	jalr	-1608(ra) # f0e <strchr>
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
     58c:	986080e7          	jalr	-1658(ra) # f0e <strchr>
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
     5ba:	0c2b8b93          	addi	s7,s7,194 # 1678 <malloc+0x15a>
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
     5cc:	09050513          	addi	a0,a0,144 # 1658 <malloc+0x13a>
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
     6b4:	fd060613          	addi	a2,a2,-48 # 1680 <malloc+0x162>
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
     6e4:	fc0b0b13          	addi	s6,s6,-64 # 16a0 <malloc+0x182>
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
     71e:	f6e50513          	addi	a0,a0,-146 # 1688 <malloc+0x16a>
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
     780:	f1450513          	addi	a0,a0,-236 # 1690 <malloc+0x172>
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
     7ba:	ef260613          	addi	a2,a2,-270 # 16a8 <malloc+0x18a>
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
     82a:	e8aa0a13          	addi	s4,s4,-374 # 16b0 <malloc+0x192>
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
     860:	e5c60613          	addi	a2,a2,-420 # 16b8 <malloc+0x19a>
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
     8c6:	dbe60613          	addi	a2,a2,-578 # 1680 <malloc+0x162>
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
     8f6:	dde60613          	addi	a2,a2,-546 # 16d0 <malloc+0x1b2>
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
     938:	d8c50513          	addi	a0,a0,-628 # 16c0 <malloc+0x1a2>
     93c:	fffff097          	auipc	ra,0xfffff
     940:	71a080e7          	jalr	1818(ra) # 56 <panic>
        panic("syntax - missing )");
     944:	00001517          	auipc	a0,0x1
     948:	d9450513          	addi	a0,a0,-620 # 16d8 <malloc+0x1ba>
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
     974:	ddc70713          	addi	a4,a4,-548 # 174c <malloc+0x22e>
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
     a02:	4c4080e7          	jalr	1220(ra) # ec2 <strlen>
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
     a20:	cd460613          	addi	a2,a2,-812 # 16f0 <malloc+0x1d2>
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
     a56:	ca658593          	addi	a1,a1,-858 # 16f8 <malloc+0x1da>
     a5a:	4509                	li	a0,2
     a5c:	00001097          	auipc	ra,0x1
     a60:	9dc080e7          	jalr	-1572(ra) # 1438 <fprintf>
        panic("syntax");
     a64:	00001517          	auipc	a0,0x1
     a68:	c2450513          	addi	a0,a0,-988 # 1688 <malloc+0x16a>
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
     aac:	00000097          	auipc	ra,0x0
     ab0:	642080e7          	jalr	1602(ra) # 10ee <wait>
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
     ada:	3ec080e7          	jalr	1004(ra) # ec2 <strlen>
     ade:	fff5079b          	addiw	a5,a0,-1
     ae2:	1782                	slli	a5,a5,0x20
     ae4:	9381                	srli	a5,a5,0x20
     ae6:	97a6                	add	a5,a5,s1
     ae8:	00078023          	sb	zero,0(a5)
        if (chdir(buf + 3) < 0)
     aec:	048d                	addi	s1,s1,3
     aee:	8526                	mv	a0,s1
     af0:	00000097          	auipc	ra,0x0
     af4:	666080e7          	jalr	1638(ra) # 1156 <chdir>
     af8:	fa055ee3          	bgez	a0,ab4 <parse_buffer+0x40>
            fprintf(2, "cannot cd %s\n", buf + 3);
     afc:	8626                	mv	a2,s1
     afe:	00001597          	auipc	a1,0x1
     b02:	c0a58593          	addi	a1,a1,-1014 # 1708 <malloc+0x1ea>
     b06:	4509                	li	a0,2
     b08:	00001097          	auipc	ra,0x1
     b0c:	930080e7          	jalr	-1744(ra) # 1438 <fprintf>
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
     b30:	5ba080e7          	jalr	1466(ra) # 10e6 <exit>
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
     b5c:	bc048493          	addi	s1,s1,-1088 # 1718 <malloc+0x1fa>
     b60:	4589                	li	a1,2
     b62:	8526                	mv	a0,s1
     b64:	00000097          	auipc	ra,0x0
     b68:	5c2080e7          	jalr	1474(ra) # 1126 <open>
     b6c:	00054963          	bltz	a0,b7e <main+0x38>
        if (fd >= 3)
     b70:	4789                	li	a5,2
     b72:	fea7d7e3          	bge	a5,a0,b60 <main+0x1a>
            close(fd);
     b76:	00000097          	auipc	ra,0x0
     b7a:	598080e7          	jalr	1432(ra) # 110e <close>
    if (argc == 2)
     b7e:	4789                	li	a5,2
    while (getcmd(buf, sizeof(buf)) >= 0)
     b80:	00001497          	auipc	s1,0x1
     b84:	4a048493          	addi	s1,s1,1184 # 2020 <buf.0>
    if (argc == 2)
     b88:	08f91463          	bne	s2,a5,c10 <main+0xca>
        char *shell_script_file = argv[1];
     b8c:	0089b483          	ld	s1,8(s3)
        int shfd = open(shell_script_file, O_RDWR);
     b90:	4589                	li	a1,2
     b92:	8526                	mv	a0,s1
     b94:	00000097          	auipc	ra,0x0
     b98:	592080e7          	jalr	1426(ra) # 1126 <open>
     b9c:	892a                	mv	s2,a0
        if (shfd < 0)
     b9e:	04054663          	bltz	a0,bea <main+0xa4>
        read(shfd, buf, sizeof(buf));
     ba2:	07800613          	li	a2,120
     ba6:	00001597          	auipc	a1,0x1
     baa:	47a58593          	addi	a1,a1,1146 # 2020 <buf.0>
     bae:	00000097          	auipc	ra,0x0
     bb2:	550080e7          	jalr	1360(ra) # 10fe <read>
            parse_buffer(buf);
     bb6:	00001497          	auipc	s1,0x1
     bba:	46a48493          	addi	s1,s1,1130 # 2020 <buf.0>
     bbe:	8526                	mv	a0,s1
     bc0:	00000097          	auipc	ra,0x0
     bc4:	eb4080e7          	jalr	-332(ra) # a74 <parse_buffer>
        } while (read(shfd, buf, sizeof(buf)) == sizeof(buf));
     bc8:	07800613          	li	a2,120
     bcc:	85a6                	mv	a1,s1
     bce:	854a                	mv	a0,s2
     bd0:	00000097          	auipc	ra,0x0
     bd4:	52e080e7          	jalr	1326(ra) # 10fe <read>
     bd8:	07800793          	li	a5,120
     bdc:	fef501e3          	beq	a0,a5,bbe <main+0x78>
        exit(0);
     be0:	4501                	li	a0,0
     be2:	00000097          	auipc	ra,0x0
     be6:	504080e7          	jalr	1284(ra) # 10e6 <exit>
            printf("Failed to open %s\n", shell_script_file);
     bea:	85a6                	mv	a1,s1
     bec:	00001517          	auipc	a0,0x1
     bf0:	b3450513          	addi	a0,a0,-1228 # 1720 <malloc+0x202>
     bf4:	00001097          	auipc	ra,0x1
     bf8:	872080e7          	jalr	-1934(ra) # 1466 <printf>
            exit(1);
     bfc:	4505                	li	a0,1
     bfe:	00000097          	auipc	ra,0x0
     c02:	4e8080e7          	jalr	1256(ra) # 10e6 <exit>
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
     c28:	4c2080e7          	jalr	1218(ra) # 10e6 <exit>

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
     c60:	172080e7          	jalr	370(ra) # dce <twhoami>
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
     cac:	ac050513          	addi	a0,a0,-1344 # 1768 <malloc+0x24a>
     cb0:	00000097          	auipc	ra,0x0
     cb4:	7b6080e7          	jalr	1974(ra) # 1466 <printf>
        exit(-1);
     cb8:	557d                	li	a0,-1
     cba:	00000097          	auipc	ra,0x0
     cbe:	42c080e7          	jalr	1068(ra) # 10e6 <exit>
    {
        // give up the cpu for other threads
        tyield();
     cc2:	00000097          	auipc	ra,0x0
     cc6:	0f4080e7          	jalr	244(ra) # db6 <tyield>
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
     ce0:	0f2080e7          	jalr	242(ra) # dce <twhoami>
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
     d24:	096080e7          	jalr	150(ra) # db6 <tyield>
}
     d28:	60e2                	ld	ra,24(sp)
     d2a:	6442                	ld	s0,16(sp)
     d2c:	64a2                	ld	s1,8(sp)
     d2e:	6105                	addi	sp,sp,32
     d30:	8082                	ret
        printf("releasing lock we are not holding");
     d32:	00001517          	auipc	a0,0x1
     d36:	a5e50513          	addi	a0,a0,-1442 # 1790 <malloc+0x272>
     d3a:	00000097          	auipc	ra,0x0
     d3e:	72c080e7          	jalr	1836(ra) # 1466 <printf>
        exit(-1);
     d42:	557d                	li	a0,-1
     d44:	00000097          	auipc	ra,0x0
     d48:	3a2080e7          	jalr	930(ra) # 10e6 <exit>

0000000000000d4c <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
     d4c:	1141                	addi	sp,sp,-16
     d4e:	e422                	sd	s0,8(sp)
     d50:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     d52:	00001717          	auipc	a4,0x1
     d56:	2be73703          	ld	a4,702(a4) # 2010 <current_thread>
     d5a:	47c1                	li	a5,16
     d5c:	c319                	beqz	a4,d62 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
     d5e:	37fd                	addiw	a5,a5,-1
     d60:	fff5                	bnez	a5,d5c <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
     d62:	6422                	ld	s0,8(sp)
     d64:	0141                	addi	sp,sp,16
     d66:	8082                	ret

0000000000000d68 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     d68:	7179                	addi	sp,sp,-48
     d6a:	f406                	sd	ra,40(sp)
     d6c:	f022                	sd	s0,32(sp)
     d6e:	ec26                	sd	s1,24(sp)
     d70:	e84a                	sd	s2,16(sp)
     d72:	e44e                	sd	s3,8(sp)
     d74:	1800                	addi	s0,sp,48
     d76:	84aa                	mv	s1,a0
     d78:	89b2                	mv	s3,a2
     d7a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     d7c:	09000513          	li	a0,144
     d80:	00000097          	auipc	ra,0x0
     d84:	79e080e7          	jalr	1950(ra) # 151e <malloc>
     d88:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     d8a:	478d                	li	a5,3
     d8c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     d8e:	609c                	ld	a5,0(s1)
     d90:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     d94:	609c                	ld	a5,0(s1)
     d96:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
     d9a:	70a2                	ld	ra,40(sp)
     d9c:	7402                	ld	s0,32(sp)
     d9e:	64e2                	ld	s1,24(sp)
     da0:	6942                	ld	s2,16(sp)
     da2:	69a2                	ld	s3,8(sp)
     da4:	6145                	addi	sp,sp,48
     da6:	8082                	ret

0000000000000da8 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
     da8:	1141                	addi	sp,sp,-16
     daa:	e422                	sd	s0,8(sp)
     dac:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
     dae:	4501                	li	a0,0
     db0:	6422                	ld	s0,8(sp)
     db2:	0141                	addi	sp,sp,16
     db4:	8082                	ret

0000000000000db6 <tyield>:

void tyield()
{
     db6:	1141                	addi	sp,sp,-16
     db8:	e422                	sd	s0,8(sp)
     dba:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
     dbc:	00001797          	auipc	a5,0x1
     dc0:	2547b783          	ld	a5,596(a5) # 2010 <current_thread>
     dc4:	470d                	li	a4,3
     dc6:	dfb8                	sw	a4,120(a5)
    tsched();
}
     dc8:	6422                	ld	s0,8(sp)
     dca:	0141                	addi	sp,sp,16
     dcc:	8082                	ret

0000000000000dce <twhoami>:

uint8 twhoami()
{
     dce:	1141                	addi	sp,sp,-16
     dd0:	e422                	sd	s0,8(sp)
     dd2:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
     dd4:	4501                	li	a0,0
     dd6:	6422                	ld	s0,8(sp)
     dd8:	0141                	addi	sp,sp,16
     dda:	8082                	ret

0000000000000ddc <tswtch>:
     ddc:	00153023          	sd	ra,0(a0)
     de0:	00253423          	sd	sp,8(a0)
     de4:	e900                	sd	s0,16(a0)
     de6:	ed04                	sd	s1,24(a0)
     de8:	03253023          	sd	s2,32(a0)
     dec:	03353423          	sd	s3,40(a0)
     df0:	03453823          	sd	s4,48(a0)
     df4:	03553c23          	sd	s5,56(a0)
     df8:	05653023          	sd	s6,64(a0)
     dfc:	05753423          	sd	s7,72(a0)
     e00:	05853823          	sd	s8,80(a0)
     e04:	05953c23          	sd	s9,88(a0)
     e08:	07a53023          	sd	s10,96(a0)
     e0c:	07b53423          	sd	s11,104(a0)
     e10:	0005b083          	ld	ra,0(a1)
     e14:	0085b103          	ld	sp,8(a1)
     e18:	6980                	ld	s0,16(a1)
     e1a:	6d84                	ld	s1,24(a1)
     e1c:	0205b903          	ld	s2,32(a1)
     e20:	0285b983          	ld	s3,40(a1)
     e24:	0305ba03          	ld	s4,48(a1)
     e28:	0385ba83          	ld	s5,56(a1)
     e2c:	0405bb03          	ld	s6,64(a1)
     e30:	0485bb83          	ld	s7,72(a1)
     e34:	0505bc03          	ld	s8,80(a1)
     e38:	0585bc83          	ld	s9,88(a1)
     e3c:	0605bd03          	ld	s10,96(a1)
     e40:	0685bd83          	ld	s11,104(a1)
     e44:	8082                	ret

0000000000000e46 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     e46:	1101                	addi	sp,sp,-32
     e48:	ec06                	sd	ra,24(sp)
     e4a:	e822                	sd	s0,16(sp)
     e4c:	e426                	sd	s1,8(sp)
     e4e:	e04a                	sd	s2,0(sp)
     e50:	1000                	addi	s0,sp,32
     e52:	84aa                	mv	s1,a0
     e54:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     e56:	09000513          	li	a0,144
     e5a:	00000097          	auipc	ra,0x0
     e5e:	6c4080e7          	jalr	1732(ra) # 151e <malloc>

    main_thread->tid = 0;
     e62:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     e66:	85ca                	mv	a1,s2
     e68:	8526                	mv	a0,s1
     e6a:	00000097          	auipc	ra,0x0
     e6e:	cdc080e7          	jalr	-804(ra) # b46 <main>
    exit(res);
     e72:	00000097          	auipc	ra,0x0
     e76:	274080e7          	jalr	628(ra) # 10e6 <exit>

0000000000000e7a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     e7a:	1141                	addi	sp,sp,-16
     e7c:	e422                	sd	s0,8(sp)
     e7e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
     e80:	87aa                	mv	a5,a0
     e82:	0585                	addi	a1,a1,1
     e84:	0785                	addi	a5,a5,1
     e86:	fff5c703          	lbu	a4,-1(a1)
     e8a:	fee78fa3          	sb	a4,-1(a5)
     e8e:	fb75                	bnez	a4,e82 <strcpy+0x8>
        ;
    return os;
}
     e90:	6422                	ld	s0,8(sp)
     e92:	0141                	addi	sp,sp,16
     e94:	8082                	ret

0000000000000e96 <strcmp>:

int strcmp(const char *p, const char *q)
{
     e96:	1141                	addi	sp,sp,-16
     e98:	e422                	sd	s0,8(sp)
     e9a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
     e9c:	00054783          	lbu	a5,0(a0)
     ea0:	cb91                	beqz	a5,eb4 <strcmp+0x1e>
     ea2:	0005c703          	lbu	a4,0(a1)
     ea6:	00f71763          	bne	a4,a5,eb4 <strcmp+0x1e>
        p++, q++;
     eaa:	0505                	addi	a0,a0,1
     eac:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
     eae:	00054783          	lbu	a5,0(a0)
     eb2:	fbe5                	bnez	a5,ea2 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
     eb4:	0005c503          	lbu	a0,0(a1)
}
     eb8:	40a7853b          	subw	a0,a5,a0
     ebc:	6422                	ld	s0,8(sp)
     ebe:	0141                	addi	sp,sp,16
     ec0:	8082                	ret

0000000000000ec2 <strlen>:

uint strlen(const char *s)
{
     ec2:	1141                	addi	sp,sp,-16
     ec4:	e422                	sd	s0,8(sp)
     ec6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
     ec8:	00054783          	lbu	a5,0(a0)
     ecc:	cf91                	beqz	a5,ee8 <strlen+0x26>
     ece:	0505                	addi	a0,a0,1
     ed0:	87aa                	mv	a5,a0
     ed2:	86be                	mv	a3,a5
     ed4:	0785                	addi	a5,a5,1
     ed6:	fff7c703          	lbu	a4,-1(a5)
     eda:	ff65                	bnez	a4,ed2 <strlen+0x10>
     edc:	40a6853b          	subw	a0,a3,a0
     ee0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
     ee2:	6422                	ld	s0,8(sp)
     ee4:	0141                	addi	sp,sp,16
     ee6:	8082                	ret
    for (n = 0; s[n]; n++)
     ee8:	4501                	li	a0,0
     eea:	bfe5                	j	ee2 <strlen+0x20>

0000000000000eec <memset>:

void *
memset(void *dst, int c, uint n)
{
     eec:	1141                	addi	sp,sp,-16
     eee:	e422                	sd	s0,8(sp)
     ef0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
     ef2:	ca19                	beqz	a2,f08 <memset+0x1c>
     ef4:	87aa                	mv	a5,a0
     ef6:	1602                	slli	a2,a2,0x20
     ef8:	9201                	srli	a2,a2,0x20
     efa:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
     efe:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
     f02:	0785                	addi	a5,a5,1
     f04:	fee79de3          	bne	a5,a4,efe <memset+0x12>
    }
    return dst;
}
     f08:	6422                	ld	s0,8(sp)
     f0a:	0141                	addi	sp,sp,16
     f0c:	8082                	ret

0000000000000f0e <strchr>:

char *
strchr(const char *s, char c)
{
     f0e:	1141                	addi	sp,sp,-16
     f10:	e422                	sd	s0,8(sp)
     f12:	0800                	addi	s0,sp,16
    for (; *s; s++)
     f14:	00054783          	lbu	a5,0(a0)
     f18:	cb99                	beqz	a5,f2e <strchr+0x20>
        if (*s == c)
     f1a:	00f58763          	beq	a1,a5,f28 <strchr+0x1a>
    for (; *s; s++)
     f1e:	0505                	addi	a0,a0,1
     f20:	00054783          	lbu	a5,0(a0)
     f24:	fbfd                	bnez	a5,f1a <strchr+0xc>
            return (char *)s;
    return 0;
     f26:	4501                	li	a0,0
}
     f28:	6422                	ld	s0,8(sp)
     f2a:	0141                	addi	sp,sp,16
     f2c:	8082                	ret
    return 0;
     f2e:	4501                	li	a0,0
     f30:	bfe5                	j	f28 <strchr+0x1a>

0000000000000f32 <gets>:

char *
gets(char *buf, int max)
{
     f32:	711d                	addi	sp,sp,-96
     f34:	ec86                	sd	ra,88(sp)
     f36:	e8a2                	sd	s0,80(sp)
     f38:	e4a6                	sd	s1,72(sp)
     f3a:	e0ca                	sd	s2,64(sp)
     f3c:	fc4e                	sd	s3,56(sp)
     f3e:	f852                	sd	s4,48(sp)
     f40:	f456                	sd	s5,40(sp)
     f42:	f05a                	sd	s6,32(sp)
     f44:	ec5e                	sd	s7,24(sp)
     f46:	1080                	addi	s0,sp,96
     f48:	8baa                	mv	s7,a0
     f4a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
     f4c:	892a                	mv	s2,a0
     f4e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
     f50:	4aa9                	li	s5,10
     f52:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
     f54:	89a6                	mv	s3,s1
     f56:	2485                	addiw	s1,s1,1
     f58:	0344d863          	bge	s1,s4,f88 <gets+0x56>
        cc = read(0, &c, 1);
     f5c:	4605                	li	a2,1
     f5e:	faf40593          	addi	a1,s0,-81
     f62:	4501                	li	a0,0
     f64:	00000097          	auipc	ra,0x0
     f68:	19a080e7          	jalr	410(ra) # 10fe <read>
        if (cc < 1)
     f6c:	00a05e63          	blez	a0,f88 <gets+0x56>
        buf[i++] = c;
     f70:	faf44783          	lbu	a5,-81(s0)
     f74:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
     f78:	01578763          	beq	a5,s5,f86 <gets+0x54>
     f7c:	0905                	addi	s2,s2,1
     f7e:	fd679be3          	bne	a5,s6,f54 <gets+0x22>
    for (i = 0; i + 1 < max;)
     f82:	89a6                	mv	s3,s1
     f84:	a011                	j	f88 <gets+0x56>
     f86:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
     f88:	99de                	add	s3,s3,s7
     f8a:	00098023          	sb	zero,0(s3)
    return buf;
}
     f8e:	855e                	mv	a0,s7
     f90:	60e6                	ld	ra,88(sp)
     f92:	6446                	ld	s0,80(sp)
     f94:	64a6                	ld	s1,72(sp)
     f96:	6906                	ld	s2,64(sp)
     f98:	79e2                	ld	s3,56(sp)
     f9a:	7a42                	ld	s4,48(sp)
     f9c:	7aa2                	ld	s5,40(sp)
     f9e:	7b02                	ld	s6,32(sp)
     fa0:	6be2                	ld	s7,24(sp)
     fa2:	6125                	addi	sp,sp,96
     fa4:	8082                	ret

0000000000000fa6 <stat>:

int stat(const char *n, struct stat *st)
{
     fa6:	1101                	addi	sp,sp,-32
     fa8:	ec06                	sd	ra,24(sp)
     faa:	e822                	sd	s0,16(sp)
     fac:	e426                	sd	s1,8(sp)
     fae:	e04a                	sd	s2,0(sp)
     fb0:	1000                	addi	s0,sp,32
     fb2:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     fb4:	4581                	li	a1,0
     fb6:	00000097          	auipc	ra,0x0
     fba:	170080e7          	jalr	368(ra) # 1126 <open>
    if (fd < 0)
     fbe:	02054563          	bltz	a0,fe8 <stat+0x42>
     fc2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
     fc4:	85ca                	mv	a1,s2
     fc6:	00000097          	auipc	ra,0x0
     fca:	178080e7          	jalr	376(ra) # 113e <fstat>
     fce:	892a                	mv	s2,a0
    close(fd);
     fd0:	8526                	mv	a0,s1
     fd2:	00000097          	auipc	ra,0x0
     fd6:	13c080e7          	jalr	316(ra) # 110e <close>
    return r;
}
     fda:	854a                	mv	a0,s2
     fdc:	60e2                	ld	ra,24(sp)
     fde:	6442                	ld	s0,16(sp)
     fe0:	64a2                	ld	s1,8(sp)
     fe2:	6902                	ld	s2,0(sp)
     fe4:	6105                	addi	sp,sp,32
     fe6:	8082                	ret
        return -1;
     fe8:	597d                	li	s2,-1
     fea:	bfc5                	j	fda <stat+0x34>

0000000000000fec <atoi>:

int atoi(const char *s)
{
     fec:	1141                	addi	sp,sp,-16
     fee:	e422                	sd	s0,8(sp)
     ff0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
     ff2:	00054683          	lbu	a3,0(a0)
     ff6:	fd06879b          	addiw	a5,a3,-48
     ffa:	0ff7f793          	zext.b	a5,a5
     ffe:	4625                	li	a2,9
    1000:	02f66863          	bltu	a2,a5,1030 <atoi+0x44>
    1004:	872a                	mv	a4,a0
    n = 0;
    1006:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    1008:	0705                	addi	a4,a4,1
    100a:	0025179b          	slliw	a5,a0,0x2
    100e:	9fa9                	addw	a5,a5,a0
    1010:	0017979b          	slliw	a5,a5,0x1
    1014:	9fb5                	addw	a5,a5,a3
    1016:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    101a:	00074683          	lbu	a3,0(a4)
    101e:	fd06879b          	addiw	a5,a3,-48
    1022:	0ff7f793          	zext.b	a5,a5
    1026:	fef671e3          	bgeu	a2,a5,1008 <atoi+0x1c>
    return n;
}
    102a:	6422                	ld	s0,8(sp)
    102c:	0141                	addi	sp,sp,16
    102e:	8082                	ret
    n = 0;
    1030:	4501                	li	a0,0
    1032:	bfe5                	j	102a <atoi+0x3e>

0000000000001034 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    1034:	1141                	addi	sp,sp,-16
    1036:	e422                	sd	s0,8(sp)
    1038:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    103a:	02b57463          	bgeu	a0,a1,1062 <memmove+0x2e>
    {
        while (n-- > 0)
    103e:	00c05f63          	blez	a2,105c <memmove+0x28>
    1042:	1602                	slli	a2,a2,0x20
    1044:	9201                	srli	a2,a2,0x20
    1046:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    104a:	872a                	mv	a4,a0
            *dst++ = *src++;
    104c:	0585                	addi	a1,a1,1
    104e:	0705                	addi	a4,a4,1
    1050:	fff5c683          	lbu	a3,-1(a1)
    1054:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    1058:	fee79ae3          	bne	a5,a4,104c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    105c:	6422                	ld	s0,8(sp)
    105e:	0141                	addi	sp,sp,16
    1060:	8082                	ret
        dst += n;
    1062:	00c50733          	add	a4,a0,a2
        src += n;
    1066:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1068:	fec05ae3          	blez	a2,105c <memmove+0x28>
    106c:	fff6079b          	addiw	a5,a2,-1
    1070:	1782                	slli	a5,a5,0x20
    1072:	9381                	srli	a5,a5,0x20
    1074:	fff7c793          	not	a5,a5
    1078:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    107a:	15fd                	addi	a1,a1,-1
    107c:	177d                	addi	a4,a4,-1
    107e:	0005c683          	lbu	a3,0(a1)
    1082:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    1086:	fee79ae3          	bne	a5,a4,107a <memmove+0x46>
    108a:	bfc9                	j	105c <memmove+0x28>

000000000000108c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    108c:	1141                	addi	sp,sp,-16
    108e:	e422                	sd	s0,8(sp)
    1090:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    1092:	ca05                	beqz	a2,10c2 <memcmp+0x36>
    1094:	fff6069b          	addiw	a3,a2,-1
    1098:	1682                	slli	a3,a3,0x20
    109a:	9281                	srli	a3,a3,0x20
    109c:	0685                	addi	a3,a3,1
    109e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    10a0:	00054783          	lbu	a5,0(a0)
    10a4:	0005c703          	lbu	a4,0(a1)
    10a8:	00e79863          	bne	a5,a4,10b8 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    10ac:	0505                	addi	a0,a0,1
        p2++;
    10ae:	0585                	addi	a1,a1,1
    while (n-- > 0)
    10b0:	fed518e3          	bne	a0,a3,10a0 <memcmp+0x14>
    }
    return 0;
    10b4:	4501                	li	a0,0
    10b6:	a019                	j	10bc <memcmp+0x30>
            return *p1 - *p2;
    10b8:	40e7853b          	subw	a0,a5,a4
}
    10bc:	6422                	ld	s0,8(sp)
    10be:	0141                	addi	sp,sp,16
    10c0:	8082                	ret
    return 0;
    10c2:	4501                	li	a0,0
    10c4:	bfe5                	j	10bc <memcmp+0x30>

00000000000010c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    10c6:	1141                	addi	sp,sp,-16
    10c8:	e406                	sd	ra,8(sp)
    10ca:	e022                	sd	s0,0(sp)
    10cc:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    10ce:	00000097          	auipc	ra,0x0
    10d2:	f66080e7          	jalr	-154(ra) # 1034 <memmove>
}
    10d6:	60a2                	ld	ra,8(sp)
    10d8:	6402                	ld	s0,0(sp)
    10da:	0141                	addi	sp,sp,16
    10dc:	8082                	ret

00000000000010de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    10de:	4885                	li	a7,1
 ecall
    10e0:	00000073          	ecall
 ret
    10e4:	8082                	ret

00000000000010e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
    10e6:	4889                	li	a7,2
 ecall
    10e8:	00000073          	ecall
 ret
    10ec:	8082                	ret

00000000000010ee <wait>:
.global wait
wait:
 li a7, SYS_wait
    10ee:	488d                	li	a7,3
 ecall
    10f0:	00000073          	ecall
 ret
    10f4:	8082                	ret

00000000000010f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    10f6:	4891                	li	a7,4
 ecall
    10f8:	00000073          	ecall
 ret
    10fc:	8082                	ret

00000000000010fe <read>:
.global read
read:
 li a7, SYS_read
    10fe:	4895                	li	a7,5
 ecall
    1100:	00000073          	ecall
 ret
    1104:	8082                	ret

0000000000001106 <write>:
.global write
write:
 li a7, SYS_write
    1106:	48c1                	li	a7,16
 ecall
    1108:	00000073          	ecall
 ret
    110c:	8082                	ret

000000000000110e <close>:
.global close
close:
 li a7, SYS_close
    110e:	48d5                	li	a7,21
 ecall
    1110:	00000073          	ecall
 ret
    1114:	8082                	ret

0000000000001116 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1116:	4899                	li	a7,6
 ecall
    1118:	00000073          	ecall
 ret
    111c:	8082                	ret

000000000000111e <exec>:
.global exec
exec:
 li a7, SYS_exec
    111e:	489d                	li	a7,7
 ecall
    1120:	00000073          	ecall
 ret
    1124:	8082                	ret

0000000000001126 <open>:
.global open
open:
 li a7, SYS_open
    1126:	48bd                	li	a7,15
 ecall
    1128:	00000073          	ecall
 ret
    112c:	8082                	ret

000000000000112e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    112e:	48c5                	li	a7,17
 ecall
    1130:	00000073          	ecall
 ret
    1134:	8082                	ret

0000000000001136 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1136:	48c9                	li	a7,18
 ecall
    1138:	00000073          	ecall
 ret
    113c:	8082                	ret

000000000000113e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    113e:	48a1                	li	a7,8
 ecall
    1140:	00000073          	ecall
 ret
    1144:	8082                	ret

0000000000001146 <link>:
.global link
link:
 li a7, SYS_link
    1146:	48cd                	li	a7,19
 ecall
    1148:	00000073          	ecall
 ret
    114c:	8082                	ret

000000000000114e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    114e:	48d1                	li	a7,20
 ecall
    1150:	00000073          	ecall
 ret
    1154:	8082                	ret

0000000000001156 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1156:	48a5                	li	a7,9
 ecall
    1158:	00000073          	ecall
 ret
    115c:	8082                	ret

000000000000115e <dup>:
.global dup
dup:
 li a7, SYS_dup
    115e:	48a9                	li	a7,10
 ecall
    1160:	00000073          	ecall
 ret
    1164:	8082                	ret

0000000000001166 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1166:	48ad                	li	a7,11
 ecall
    1168:	00000073          	ecall
 ret
    116c:	8082                	ret

000000000000116e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    116e:	48b1                	li	a7,12
 ecall
    1170:	00000073          	ecall
 ret
    1174:	8082                	ret

0000000000001176 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1176:	48b5                	li	a7,13
 ecall
    1178:	00000073          	ecall
 ret
    117c:	8082                	ret

000000000000117e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    117e:	48b9                	li	a7,14
 ecall
    1180:	00000073          	ecall
 ret
    1184:	8082                	ret

0000000000001186 <ps>:
.global ps
ps:
 li a7, SYS_ps
    1186:	48d9                	li	a7,22
 ecall
    1188:	00000073          	ecall
 ret
    118c:	8082                	ret

000000000000118e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    118e:	48dd                	li	a7,23
 ecall
    1190:	00000073          	ecall
 ret
    1194:	8082                	ret

0000000000001196 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    1196:	48e1                	li	a7,24
 ecall
    1198:	00000073          	ecall
 ret
    119c:	8082                	ret

000000000000119e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    119e:	1101                	addi	sp,sp,-32
    11a0:	ec06                	sd	ra,24(sp)
    11a2:	e822                	sd	s0,16(sp)
    11a4:	1000                	addi	s0,sp,32
    11a6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    11aa:	4605                	li	a2,1
    11ac:	fef40593          	addi	a1,s0,-17
    11b0:	00000097          	auipc	ra,0x0
    11b4:	f56080e7          	jalr	-170(ra) # 1106 <write>
}
    11b8:	60e2                	ld	ra,24(sp)
    11ba:	6442                	ld	s0,16(sp)
    11bc:	6105                	addi	sp,sp,32
    11be:	8082                	ret

00000000000011c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    11c0:	7139                	addi	sp,sp,-64
    11c2:	fc06                	sd	ra,56(sp)
    11c4:	f822                	sd	s0,48(sp)
    11c6:	f426                	sd	s1,40(sp)
    11c8:	f04a                	sd	s2,32(sp)
    11ca:	ec4e                	sd	s3,24(sp)
    11cc:	0080                	addi	s0,sp,64
    11ce:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    11d0:	c299                	beqz	a3,11d6 <printint+0x16>
    11d2:	0805c963          	bltz	a1,1264 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    11d6:	2581                	sext.w	a1,a1
  neg = 0;
    11d8:	4881                	li	a7,0
    11da:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    11de:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    11e0:	2601                	sext.w	a2,a2
    11e2:	00000517          	auipc	a0,0x0
    11e6:	63650513          	addi	a0,a0,1590 # 1818 <digits>
    11ea:	883a                	mv	a6,a4
    11ec:	2705                	addiw	a4,a4,1
    11ee:	02c5f7bb          	remuw	a5,a1,a2
    11f2:	1782                	slli	a5,a5,0x20
    11f4:	9381                	srli	a5,a5,0x20
    11f6:	97aa                	add	a5,a5,a0
    11f8:	0007c783          	lbu	a5,0(a5)
    11fc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1200:	0005879b          	sext.w	a5,a1
    1204:	02c5d5bb          	divuw	a1,a1,a2
    1208:	0685                	addi	a3,a3,1
    120a:	fec7f0e3          	bgeu	a5,a2,11ea <printint+0x2a>
  if(neg)
    120e:	00088c63          	beqz	a7,1226 <printint+0x66>
    buf[i++] = '-';
    1212:	fd070793          	addi	a5,a4,-48
    1216:	00878733          	add	a4,a5,s0
    121a:	02d00793          	li	a5,45
    121e:	fef70823          	sb	a5,-16(a4)
    1222:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    1226:	02e05863          	blez	a4,1256 <printint+0x96>
    122a:	fc040793          	addi	a5,s0,-64
    122e:	00e78933          	add	s2,a5,a4
    1232:	fff78993          	addi	s3,a5,-1
    1236:	99ba                	add	s3,s3,a4
    1238:	377d                	addiw	a4,a4,-1
    123a:	1702                	slli	a4,a4,0x20
    123c:	9301                	srli	a4,a4,0x20
    123e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1242:	fff94583          	lbu	a1,-1(s2)
    1246:	8526                	mv	a0,s1
    1248:	00000097          	auipc	ra,0x0
    124c:	f56080e7          	jalr	-170(ra) # 119e <putc>
  while(--i >= 0)
    1250:	197d                	addi	s2,s2,-1
    1252:	ff3918e3          	bne	s2,s3,1242 <printint+0x82>
}
    1256:	70e2                	ld	ra,56(sp)
    1258:	7442                	ld	s0,48(sp)
    125a:	74a2                	ld	s1,40(sp)
    125c:	7902                	ld	s2,32(sp)
    125e:	69e2                	ld	s3,24(sp)
    1260:	6121                	addi	sp,sp,64
    1262:	8082                	ret
    x = -xx;
    1264:	40b005bb          	negw	a1,a1
    neg = 1;
    1268:	4885                	li	a7,1
    x = -xx;
    126a:	bf85                	j	11da <printint+0x1a>

000000000000126c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    126c:	715d                	addi	sp,sp,-80
    126e:	e486                	sd	ra,72(sp)
    1270:	e0a2                	sd	s0,64(sp)
    1272:	fc26                	sd	s1,56(sp)
    1274:	f84a                	sd	s2,48(sp)
    1276:	f44e                	sd	s3,40(sp)
    1278:	f052                	sd	s4,32(sp)
    127a:	ec56                	sd	s5,24(sp)
    127c:	e85a                	sd	s6,16(sp)
    127e:	e45e                	sd	s7,8(sp)
    1280:	e062                	sd	s8,0(sp)
    1282:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1284:	0005c903          	lbu	s2,0(a1)
    1288:	18090c63          	beqz	s2,1420 <vprintf+0x1b4>
    128c:	8aaa                	mv	s5,a0
    128e:	8bb2                	mv	s7,a2
    1290:	00158493          	addi	s1,a1,1
  state = 0;
    1294:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1296:	02500a13          	li	s4,37
    129a:	4b55                	li	s6,21
    129c:	a839                	j	12ba <vprintf+0x4e>
        putc(fd, c);
    129e:	85ca                	mv	a1,s2
    12a0:	8556                	mv	a0,s5
    12a2:	00000097          	auipc	ra,0x0
    12a6:	efc080e7          	jalr	-260(ra) # 119e <putc>
    12aa:	a019                	j	12b0 <vprintf+0x44>
    } else if(state == '%'){
    12ac:	01498d63          	beq	s3,s4,12c6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    12b0:	0485                	addi	s1,s1,1
    12b2:	fff4c903          	lbu	s2,-1(s1)
    12b6:	16090563          	beqz	s2,1420 <vprintf+0x1b4>
    if(state == 0){
    12ba:	fe0999e3          	bnez	s3,12ac <vprintf+0x40>
      if(c == '%'){
    12be:	ff4910e3          	bne	s2,s4,129e <vprintf+0x32>
        state = '%';
    12c2:	89d2                	mv	s3,s4
    12c4:	b7f5                	j	12b0 <vprintf+0x44>
      if(c == 'd'){
    12c6:	13490263          	beq	s2,s4,13ea <vprintf+0x17e>
    12ca:	f9d9079b          	addiw	a5,s2,-99
    12ce:	0ff7f793          	zext.b	a5,a5
    12d2:	12fb6563          	bltu	s6,a5,13fc <vprintf+0x190>
    12d6:	f9d9079b          	addiw	a5,s2,-99
    12da:	0ff7f713          	zext.b	a4,a5
    12de:	10eb6f63          	bltu	s6,a4,13fc <vprintf+0x190>
    12e2:	00271793          	slli	a5,a4,0x2
    12e6:	00000717          	auipc	a4,0x0
    12ea:	4da70713          	addi	a4,a4,1242 # 17c0 <malloc+0x2a2>
    12ee:	97ba                	add	a5,a5,a4
    12f0:	439c                	lw	a5,0(a5)
    12f2:	97ba                	add	a5,a5,a4
    12f4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    12f6:	008b8913          	addi	s2,s7,8
    12fa:	4685                	li	a3,1
    12fc:	4629                	li	a2,10
    12fe:	000ba583          	lw	a1,0(s7)
    1302:	8556                	mv	a0,s5
    1304:	00000097          	auipc	ra,0x0
    1308:	ebc080e7          	jalr	-324(ra) # 11c0 <printint>
    130c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    130e:	4981                	li	s3,0
    1310:	b745                	j	12b0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1312:	008b8913          	addi	s2,s7,8
    1316:	4681                	li	a3,0
    1318:	4629                	li	a2,10
    131a:	000ba583          	lw	a1,0(s7)
    131e:	8556                	mv	a0,s5
    1320:	00000097          	auipc	ra,0x0
    1324:	ea0080e7          	jalr	-352(ra) # 11c0 <printint>
    1328:	8bca                	mv	s7,s2
      state = 0;
    132a:	4981                	li	s3,0
    132c:	b751                	j	12b0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    132e:	008b8913          	addi	s2,s7,8
    1332:	4681                	li	a3,0
    1334:	4641                	li	a2,16
    1336:	000ba583          	lw	a1,0(s7)
    133a:	8556                	mv	a0,s5
    133c:	00000097          	auipc	ra,0x0
    1340:	e84080e7          	jalr	-380(ra) # 11c0 <printint>
    1344:	8bca                	mv	s7,s2
      state = 0;
    1346:	4981                	li	s3,0
    1348:	b7a5                	j	12b0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    134a:	008b8c13          	addi	s8,s7,8
    134e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1352:	03000593          	li	a1,48
    1356:	8556                	mv	a0,s5
    1358:	00000097          	auipc	ra,0x0
    135c:	e46080e7          	jalr	-442(ra) # 119e <putc>
  putc(fd, 'x');
    1360:	07800593          	li	a1,120
    1364:	8556                	mv	a0,s5
    1366:	00000097          	auipc	ra,0x0
    136a:	e38080e7          	jalr	-456(ra) # 119e <putc>
    136e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1370:	00000b97          	auipc	s7,0x0
    1374:	4a8b8b93          	addi	s7,s7,1192 # 1818 <digits>
    1378:	03c9d793          	srli	a5,s3,0x3c
    137c:	97de                	add	a5,a5,s7
    137e:	0007c583          	lbu	a1,0(a5)
    1382:	8556                	mv	a0,s5
    1384:	00000097          	auipc	ra,0x0
    1388:	e1a080e7          	jalr	-486(ra) # 119e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    138c:	0992                	slli	s3,s3,0x4
    138e:	397d                	addiw	s2,s2,-1
    1390:	fe0914e3          	bnez	s2,1378 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1394:	8be2                	mv	s7,s8
      state = 0;
    1396:	4981                	li	s3,0
    1398:	bf21                	j	12b0 <vprintf+0x44>
        s = va_arg(ap, char*);
    139a:	008b8993          	addi	s3,s7,8
    139e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    13a2:	02090163          	beqz	s2,13c4 <vprintf+0x158>
        while(*s != 0){
    13a6:	00094583          	lbu	a1,0(s2)
    13aa:	c9a5                	beqz	a1,141a <vprintf+0x1ae>
          putc(fd, *s);
    13ac:	8556                	mv	a0,s5
    13ae:	00000097          	auipc	ra,0x0
    13b2:	df0080e7          	jalr	-528(ra) # 119e <putc>
          s++;
    13b6:	0905                	addi	s2,s2,1
        while(*s != 0){
    13b8:	00094583          	lbu	a1,0(s2)
    13bc:	f9e5                	bnez	a1,13ac <vprintf+0x140>
        s = va_arg(ap, char*);
    13be:	8bce                	mv	s7,s3
      state = 0;
    13c0:	4981                	li	s3,0
    13c2:	b5fd                	j	12b0 <vprintf+0x44>
          s = "(null)";
    13c4:	00000917          	auipc	s2,0x0
    13c8:	3f490913          	addi	s2,s2,1012 # 17b8 <malloc+0x29a>
        while(*s != 0){
    13cc:	02800593          	li	a1,40
    13d0:	bff1                	j	13ac <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    13d2:	008b8913          	addi	s2,s7,8
    13d6:	000bc583          	lbu	a1,0(s7)
    13da:	8556                	mv	a0,s5
    13dc:	00000097          	auipc	ra,0x0
    13e0:	dc2080e7          	jalr	-574(ra) # 119e <putc>
    13e4:	8bca                	mv	s7,s2
      state = 0;
    13e6:	4981                	li	s3,0
    13e8:	b5e1                	j	12b0 <vprintf+0x44>
        putc(fd, c);
    13ea:	02500593          	li	a1,37
    13ee:	8556                	mv	a0,s5
    13f0:	00000097          	auipc	ra,0x0
    13f4:	dae080e7          	jalr	-594(ra) # 119e <putc>
      state = 0;
    13f8:	4981                	li	s3,0
    13fa:	bd5d                	j	12b0 <vprintf+0x44>
        putc(fd, '%');
    13fc:	02500593          	li	a1,37
    1400:	8556                	mv	a0,s5
    1402:	00000097          	auipc	ra,0x0
    1406:	d9c080e7          	jalr	-612(ra) # 119e <putc>
        putc(fd, c);
    140a:	85ca                	mv	a1,s2
    140c:	8556                	mv	a0,s5
    140e:	00000097          	auipc	ra,0x0
    1412:	d90080e7          	jalr	-624(ra) # 119e <putc>
      state = 0;
    1416:	4981                	li	s3,0
    1418:	bd61                	j	12b0 <vprintf+0x44>
        s = va_arg(ap, char*);
    141a:	8bce                	mv	s7,s3
      state = 0;
    141c:	4981                	li	s3,0
    141e:	bd49                	j	12b0 <vprintf+0x44>
    }
  }
}
    1420:	60a6                	ld	ra,72(sp)
    1422:	6406                	ld	s0,64(sp)
    1424:	74e2                	ld	s1,56(sp)
    1426:	7942                	ld	s2,48(sp)
    1428:	79a2                	ld	s3,40(sp)
    142a:	7a02                	ld	s4,32(sp)
    142c:	6ae2                	ld	s5,24(sp)
    142e:	6b42                	ld	s6,16(sp)
    1430:	6ba2                	ld	s7,8(sp)
    1432:	6c02                	ld	s8,0(sp)
    1434:	6161                	addi	sp,sp,80
    1436:	8082                	ret

0000000000001438 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1438:	715d                	addi	sp,sp,-80
    143a:	ec06                	sd	ra,24(sp)
    143c:	e822                	sd	s0,16(sp)
    143e:	1000                	addi	s0,sp,32
    1440:	e010                	sd	a2,0(s0)
    1442:	e414                	sd	a3,8(s0)
    1444:	e818                	sd	a4,16(s0)
    1446:	ec1c                	sd	a5,24(s0)
    1448:	03043023          	sd	a6,32(s0)
    144c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1450:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1454:	8622                	mv	a2,s0
    1456:	00000097          	auipc	ra,0x0
    145a:	e16080e7          	jalr	-490(ra) # 126c <vprintf>
}
    145e:	60e2                	ld	ra,24(sp)
    1460:	6442                	ld	s0,16(sp)
    1462:	6161                	addi	sp,sp,80
    1464:	8082                	ret

0000000000001466 <printf>:

void
printf(const char *fmt, ...)
{
    1466:	711d                	addi	sp,sp,-96
    1468:	ec06                	sd	ra,24(sp)
    146a:	e822                	sd	s0,16(sp)
    146c:	1000                	addi	s0,sp,32
    146e:	e40c                	sd	a1,8(s0)
    1470:	e810                	sd	a2,16(s0)
    1472:	ec14                	sd	a3,24(s0)
    1474:	f018                	sd	a4,32(s0)
    1476:	f41c                	sd	a5,40(s0)
    1478:	03043823          	sd	a6,48(s0)
    147c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1480:	00840613          	addi	a2,s0,8
    1484:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1488:	85aa                	mv	a1,a0
    148a:	4505                	li	a0,1
    148c:	00000097          	auipc	ra,0x0
    1490:	de0080e7          	jalr	-544(ra) # 126c <vprintf>
}
    1494:	60e2                	ld	ra,24(sp)
    1496:	6442                	ld	s0,16(sp)
    1498:	6125                	addi	sp,sp,96
    149a:	8082                	ret

000000000000149c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    149c:	1141                	addi	sp,sp,-16
    149e:	e422                	sd	s0,8(sp)
    14a0:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    14a2:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14a6:	00001797          	auipc	a5,0x1
    14aa:	b727b783          	ld	a5,-1166(a5) # 2018 <freep>
    14ae:	a02d                	j	14d8 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    14b0:	4618                	lw	a4,8(a2)
    14b2:	9f2d                	addw	a4,a4,a1
    14b4:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    14b8:	6398                	ld	a4,0(a5)
    14ba:	6310                	ld	a2,0(a4)
    14bc:	a83d                	j	14fa <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    14be:	ff852703          	lw	a4,-8(a0)
    14c2:	9f31                	addw	a4,a4,a2
    14c4:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    14c6:	ff053683          	ld	a3,-16(a0)
    14ca:	a091                	j	150e <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14cc:	6398                	ld	a4,0(a5)
    14ce:	00e7e463          	bltu	a5,a4,14d6 <free+0x3a>
    14d2:	00e6ea63          	bltu	a3,a4,14e6 <free+0x4a>
{
    14d6:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14d8:	fed7fae3          	bgeu	a5,a3,14cc <free+0x30>
    14dc:	6398                	ld	a4,0(a5)
    14de:	00e6e463          	bltu	a3,a4,14e6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14e2:	fee7eae3          	bltu	a5,a4,14d6 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    14e6:	ff852583          	lw	a1,-8(a0)
    14ea:	6390                	ld	a2,0(a5)
    14ec:	02059813          	slli	a6,a1,0x20
    14f0:	01c85713          	srli	a4,a6,0x1c
    14f4:	9736                	add	a4,a4,a3
    14f6:	fae60de3          	beq	a2,a4,14b0 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    14fa:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    14fe:	4790                	lw	a2,8(a5)
    1500:	02061593          	slli	a1,a2,0x20
    1504:	01c5d713          	srli	a4,a1,0x1c
    1508:	973e                	add	a4,a4,a5
    150a:	fae68ae3          	beq	a3,a4,14be <free+0x22>
        p->s.ptr = bp->s.ptr;
    150e:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    1510:	00001717          	auipc	a4,0x1
    1514:	b0f73423          	sd	a5,-1272(a4) # 2018 <freep>
}
    1518:	6422                	ld	s0,8(sp)
    151a:	0141                	addi	sp,sp,16
    151c:	8082                	ret

000000000000151e <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    151e:	7139                	addi	sp,sp,-64
    1520:	fc06                	sd	ra,56(sp)
    1522:	f822                	sd	s0,48(sp)
    1524:	f426                	sd	s1,40(sp)
    1526:	f04a                	sd	s2,32(sp)
    1528:	ec4e                	sd	s3,24(sp)
    152a:	e852                	sd	s4,16(sp)
    152c:	e456                	sd	s5,8(sp)
    152e:	e05a                	sd	s6,0(sp)
    1530:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    1532:	02051493          	slli	s1,a0,0x20
    1536:	9081                	srli	s1,s1,0x20
    1538:	04bd                	addi	s1,s1,15
    153a:	8091                	srli	s1,s1,0x4
    153c:	0014899b          	addiw	s3,s1,1
    1540:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    1542:	00001517          	auipc	a0,0x1
    1546:	ad653503          	ld	a0,-1322(a0) # 2018 <freep>
    154a:	c515                	beqz	a0,1576 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    154c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    154e:	4798                	lw	a4,8(a5)
    1550:	02977f63          	bgeu	a4,s1,158e <malloc+0x70>
    if (nu < 4096)
    1554:	8a4e                	mv	s4,s3
    1556:	0009871b          	sext.w	a4,s3
    155a:	6685                	lui	a3,0x1
    155c:	00d77363          	bgeu	a4,a3,1562 <malloc+0x44>
    1560:	6a05                	lui	s4,0x1
    1562:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    1566:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    156a:	00001917          	auipc	s2,0x1
    156e:	aae90913          	addi	s2,s2,-1362 # 2018 <freep>
    if (p == (char *)-1)
    1572:	5afd                	li	s5,-1
    1574:	a895                	j	15e8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    1576:	00001797          	auipc	a5,0x1
    157a:	b2278793          	addi	a5,a5,-1246 # 2098 <base>
    157e:	00001717          	auipc	a4,0x1
    1582:	a8f73d23          	sd	a5,-1382(a4) # 2018 <freep>
    1586:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    1588:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    158c:	b7e1                	j	1554 <malloc+0x36>
            if (p->s.size == nunits)
    158e:	02e48c63          	beq	s1,a4,15c6 <malloc+0xa8>
                p->s.size -= nunits;
    1592:	4137073b          	subw	a4,a4,s3
    1596:	c798                	sw	a4,8(a5)
                p += p->s.size;
    1598:	02071693          	slli	a3,a4,0x20
    159c:	01c6d713          	srli	a4,a3,0x1c
    15a0:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    15a2:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    15a6:	00001717          	auipc	a4,0x1
    15aa:	a6a73923          	sd	a0,-1422(a4) # 2018 <freep>
            return (void *)(p + 1);
    15ae:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    15b2:	70e2                	ld	ra,56(sp)
    15b4:	7442                	ld	s0,48(sp)
    15b6:	74a2                	ld	s1,40(sp)
    15b8:	7902                	ld	s2,32(sp)
    15ba:	69e2                	ld	s3,24(sp)
    15bc:	6a42                	ld	s4,16(sp)
    15be:	6aa2                	ld	s5,8(sp)
    15c0:	6b02                	ld	s6,0(sp)
    15c2:	6121                	addi	sp,sp,64
    15c4:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    15c6:	6398                	ld	a4,0(a5)
    15c8:	e118                	sd	a4,0(a0)
    15ca:	bff1                	j	15a6 <malloc+0x88>
    hp->s.size = nu;
    15cc:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    15d0:	0541                	addi	a0,a0,16
    15d2:	00000097          	auipc	ra,0x0
    15d6:	eca080e7          	jalr	-310(ra) # 149c <free>
    return freep;
    15da:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    15de:	d971                	beqz	a0,15b2 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    15e0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    15e2:	4798                	lw	a4,8(a5)
    15e4:	fa9775e3          	bgeu	a4,s1,158e <malloc+0x70>
        if (p == freep)
    15e8:	00093703          	ld	a4,0(s2)
    15ec:	853e                	mv	a0,a5
    15ee:	fef719e3          	bne	a4,a5,15e0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    15f2:	8552                	mv	a0,s4
    15f4:	00000097          	auipc	ra,0x0
    15f8:	b7a080e7          	jalr	-1158(ra) # 116e <sbrk>
    if (p == (char *)-1)
    15fc:	fd5518e3          	bne	a0,s5,15cc <malloc+0xae>
                return 0;
    1600:	4501                	li	a0,0
    1602:	bf45                	j	15b2 <malloc+0x94>
