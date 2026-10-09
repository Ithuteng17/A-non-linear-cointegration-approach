import markdown

with open("MS-VECMmarkdown.md","r") as MSmd_file:
    md_text = MSmd_file.read()

    html_text = markdown.markdown(md_text)

with open("MS.html","w") as html_file:
    html_file.write(html_text)