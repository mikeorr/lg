m4_divert(-1)

m4_define(`_Copyleft',
`Copyright (C) 1997 Bob Hepple

This program is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more
details.

You should have received a copy of the GNU General Public
License along with this program; if not, write to the Free
Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
02139, USA.')

m4_changecom(`[[[[')

m4_dnl define(`_LOCAL',1)

m4_ifdef(`_LOCAL',
  `m4_define(`_HOMEPAGE',`//127.0.0.1/~bhepple')',
  `m4_define(`_HOMEPAGE',`//www.bit.net.au/~bhepple')')

m4_ifdef(`_LOCAL',
  `m4_define(`_SECONDPAGE',`//127.0.0.1/~bhepple')',
  `m4_define(`_SECONDPAGE',`//www.bit.net.au/~bhepple')')

m4_define(`_EMAIL_ADDRESS',bhepple@bit.net.au)

m4_define(`_MAILTO',<A HREF="mailto:$1">$2</A>)

m4_define(`_EMAILME',_MAILTO(_EMAIL_ADDRESS,$1))

m4_define(`_CODEQUOTE',<BLOCKQUOTE><PRE><CODE>$1</CODE></PRE></BLOCKQUOTE>)

m4_dnl Logical markup:

m4_define(`_EM',<EM>$1</EM>)
m4_define(`_STRONG',<STRONG>$1</STRONG>)
m4_define(`_CITE',<CITE>$1</CITE>)
m4_define(`_PRE',<BLOCKQUOTE><PRE>$1</PRE></BLOCKQUOTE>)
m4_define(`_CODE',<CODE>$1</CODE>)

m4_dnl Physical markup:

m4_define(`_BOLD',<B>$1</B>)
m4_define(`_ITALICS',<I>$1</I>)
m4_define(`_STRIKE',<S>$1</S>)
m4_define(`_SUBSCRIPT',<SUB>$1</SUB>)
m4_define(`_SUPERSCRIPT',<SUP>$1</SUP>)
m4_define(`_COURIER',<TT>$1</TT>)
m4_define(`_UNDERLINE',<U>$1</U>)
m4_define(`_SMALL',<SMALL>$1</SMALL>)
m4_define(`_BIG',<BIG>$1</BIG>)

m4_define(`_CENTER',<CENTER>$1</CENTER>)

m4_define(`_LIMAGE', <IMG SRC="$1" ALT="[$1]" WIDTH=$2 HEIGHT=$3>)

m4_define(`_RIMAGE', <IMG SRC="$1" ALT="[$1]" WIDTH=$2 HEIGHT=$3 ALIGN="right">)

m4_define(`_IMAGE', <P><CENTER><IMG SRC="$1" ALT="[$1]" WIDTH=$2 HEIGHT=$3></CENTER><P>)

m4_define(`_IMAGE2',<P><CENTER>
<IMG SRC="$1" ALT="[$1]" ALIGN=TOP WIDTH=$2 HEIGHT=$3>
<IMG SRC="$4" ALT="[$4]" ALIGN=TOP WIDTH=$5 HEIGHT=$6>
</CENTER><P>)

m4_define(`_FTP',<A HREF="http:$1">$2</A>)

m4_define(`_HEAD1', <H2>$1</H2>)

m4_define(`_HEAD2', <H3>$1</H3>)

m4_define(`_LINK', <a href="$1">$2</a>)

m4_define(`_SELFLINK', _LINK($1,$1))

m4_define(`_LOCALLINK',<A HREF="#$1">$2</A>)

m4_define(`_LABEL',<A NAME="$1"><H2>$1</H2></A>)

m4_define(`_LINK_TO_LABEL', _LOCALLINK($1,$1))

m4_define(`_PLUG',
  _LINK(http://www.ssc.com/linux/,
    _IMAGE(_HOMEPAGE/powered.gif,196,49))<BR>
`If you are wondering, Linux is a free, non-commercial
operating system for computers. It happens to be a hobby of
mine and might well interest other hackers. Click on the logo
to learn more...')

m4_define(`_HEADER', 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML> 
<HEAD> 
  <TITLE>$1</TITLE>
  <META NAME="Author" CONTENT="Bob Hepple">
</HEAD>
<BODY BGCOLOR="#FFFFFE" BACKGROUND="http:_HOMEPAGE/bg.gif" $2>
<CENTER><A NAME="Contents"><H1>$1</H1></A></CENTER><HR>)

m4_define(_COUNTER,)

m4_dnl define(`_COUNTER',<img SRC="/cgi-bin/Count.cgi?dd=T|ft=6|frgb=648bd8|md=5|pad=Y|df=bhepple$1.dat" align=absmiddle> $2)

m4_define(`_CREDITS',`For corrections/additions/suggestions for this page, please send email to: _EMAILME(Bob Hepple) <P> Copyright `&#169;' 1997 Bob Hepple. All rights reserved.')

m4_dnl ----------------------------------------------
m4_dnl TABLE OF CONTENTS

m4_define(`_Start_TOC',`<UL><P>m4_divert(-1)
  m4_define(`_H1_num',0)
  m4_define(`_H2_num',0)
  m4_define(`_H3_num',0)
  m4_define(`_H4_num',0)
  m4_divert(1)')

m4_define(`_H1', `m4_divert(-1)
  m4_define(`_H1_num',m4_incr(_H1_num))
  m4_define(`_H2_num',0)
  m4_define(`_H3_num',0)
  m4_define(`_H4_num',0)
  m4_define(`_TOC_label',`_H1_num. $1')
  m4_divert(0)<LI><A HREF="#_TOC_label">_TOC_label</A>
  m4_divert(1)<A NAME="_TOC_label"><H2>_TOC_label</H2></A>')

m4_define(`_H2', `m4_divert(-1)
  m4_define(`_H2_num',m4_incr(_H2_num))
  m4_define(`_H3_num',0)
  m4_define(`_H4_num',0)
  m4_define(`_TOC_label',`_H1_num._H2_num $1')
  m4_divert(0)<LI><A HREF="#_TOC_label">_TOC_label</A>
  m4_divert(1)<A NAME="_TOC_label"><H2>_TOC_label</H2></A>')

m4_define(`_H3', `m4_divert(-1)
  m4_define(`_H3_num',m4_incr(_H3_num))
  m4_define(`_H4_num',0)
  m4_define(`_TOC_label',`_H1_num._H2_num._H3_num $1')
  m4_divert(0)<LI><A HREF="#_TOC_label">_TOC_label</A>
  m4_divert(1)<A NAME="_TOC_label"><H2>_TOC_label</H2></A>')

m4_define(`_H4', `m4_divert(-1)
  m4_define(`_H4_num',m4_incr(_H4_num))
  m4_define(`_TOC_label',`_H1_num._H2_num._H3_num._H4_num $1')
  m4_divert(0)<LI><A HREF="#_TOC_label">_TOC_label</A>
  m4_divert(1)<A NAME="_TOC_label"><H2>_TOC_label</H2></A>')

m4_define(`_End_TOC',`m4_divert(0)</UL><P>')

m4_dnl ----------------------------------------------
m4_dnl TABLES

m4_dnl _Start_Table(Columns,TABLE parameters)
m4_dnl defaults are BORDER=1 CELLPADDING="1" CELLSPACING="1"
m4_dnl WIDTH="n" pixels or "n%" of screen width
m4_define(`_Start_Table',`<TABLE $1>')

m4_define(`_Table_Hdr_Item', `<th>$1</th>m4_ifelse($#,1,,`_Table_Hdr_Item(m4_shift($@))')')

m4_define(`_Table_Row_Item', `<td>$1</td>m4_ifelse($#,1,,`_Table_Row_Item(m4_shift($@))')')

m4_define(`_Table_Hdr',`<tr>_Table_Hdr_Item($@)</tr>')
m4_define(`_Table_Row',`<tr>_Table_Row_Item($@)</tr>')

m4_define(`_End_Table',</TABLE>)

m4_divert