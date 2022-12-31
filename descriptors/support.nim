from strformat import fmt

let headline = """
If you want to share your support to me, here's what you can do!
Thanks, I appreciate it.
"""

let projects = """
Projects:
  Star Devine on GitHub: https://github.com/Airscripts/devine
  Star my blog on GitHub: https://github.com/Airscripts/blog.airscript.it
"""

let socials = """
Socials:
  Follow me on GitHub: https://github.com/Airscripts
  Follow me on LinkedIn: https://linkedin.com/in/airscript
  Follow me on Twitter: https://twitter.com/airscript
"""

let donate = """
Donate:
  Contribute to one of my dreams sponsoring me on GitHub: https://github.com/sponsors/Airscripts?frequency=recurring
  Offer me a drink via GitHub: https://github.com/sponsors/Airscripts?frequency=one-time
  Offer me a coffee via Ko-Fi: https://ko-fi.com/airscript
"""

let other = """
Other:
  Don't miss any post on my blog: https://blog.airscript.it
  If want to talk with me, reach me out on Telegram: https://t.me/airscript
  Send me an email to: mailto:francesco@airscript.it
  I'm also on Linktree: https://linktr.ee/airscript
"""

let descriptor* = fmt"""
{headline}
{projects}
{socials}
{donate}
{other}"""