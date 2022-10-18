<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/Element">
    <xsl:for-each select="Element">
        <xsl:sort select="@type"/>
            <xsl:choose>
                <xsl:when test="@type = 'dir'">
                    <span class="dir">
                        <a href="{@webpath}"><xsl:value-of select="@webpath"/></a>
                        <script>dirSetup()</script>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                <a href="{@staticpath}">
                    <div class="media" data-thumbnailpath="{@thumbnailpath}" data-staticpath="{@staticpath}">
                        <a href="{@staticpath}"/>
                        <script>mediaSetup()</script>
                    </div>
                </a>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:for-each>
</xsl:template>

<xsl:template match="/">
<html>
    <head>
        <title>
        <xsl:choose>
            <xsl:when test="not(Element/@webpath = '/./')">
            Gallery: <xsl:value-of select="Element/@webpath"/>
            </xsl:when>
            <xsl:otherwise>
            Gallery
            </xsl:otherwise>
        </xsl:choose></title>
        <link rel="stylesheet" href="http://localhost:8080/style.css"/>
    </head>
    <body>
    <div>
        <div id="dirs">
        <span class="dir"><a href="{@webpath}">.</a></span>
            <xsl:if test="not(/Element/@webpath = '/./')">
                <span class="dir"><a id="back" href="{@webpath}">..</a></span>
                <script>
                    {
                        let back = document.getElementById('back')
                        let t = back.href.split('/')
                        t.pop()
                        back.href = t.join('/')
                    }
                </script>
            </xsl:if>
        </div>
        <br/>
        <div id="media"/>
        <script>
            const images = ['jpg', 'png', 'bmp', 'webp', 'gif', 'svg']
            const videos = ['mp4', 'mov', 'avi', 'webm', 'mkv', 'flv']
            const dirs = document.getElementById('dirs')
            const media = document.getElementById('media')

            function moveTo(where){
                let scripts = document.getElementsByTagName('script')
                let parent = scripts[scripts.length-1].parentNode
                where.appendChild(parent)
                return parent
            }

            function addElement(t, p) {
                let e = document.createElement(t)
                p.appendChild(e)
                e.src = p.dataset.staticpath
                return e
            }

            function setBackground(p){
                p.style.background = 'url('+p.dataset.thumbnailpath+')'
                p.style.backgroundSize = 'cover'
                p.style.backgroundRepeat = 'no-repeat'
                p.style.backgroundPosition = 'center'
            }

            function dirSetup(){
                let parent = moveTo(dirs)
                let a = parent.getElementsByTagName('a')[0]
                a.innerText = a.innerText.split('/').pop()
                if(a.innerText[0] == ".") {
                    parent.remove()
                }
            }

            function mediaSetup(){
                let parent = moveTo(media)
                parent.addEventListener('click',(e)=>{
                    document.location = parent.dataset.staticpath
                })
                let ext = parent.dataset.staticpath.split('.').pop()
                if (images.includes(ext)) {
                    setBackground(parent)
                }else if (videos.includes(ext)) {
                    parent.classList.add("video")
                    addElement('video', parent)
                }else{
                    parent.remove()
                }
            }
        </script>
        <xsl:apply-templates select="/Element"/>
        <script>
            {
                let v = document.getElementsByTagName('video')
                for (const e of v){
                    e.muted = 'true'
                    e.load()
                    e.addEventListener('mouseenter', (e)=>{
                        e.target.play()
                    })
                    e.addEventListener('mouseleave', (e)=>{
                        e.target.pause()
                    })
                }
            }
        </script>
    </div>
    </body>
</html>
</xsl:template>

</xsl:stylesheet>