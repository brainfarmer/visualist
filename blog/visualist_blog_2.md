# Visualist blog 2

## The Story Mapping Process

Functional thinking is thinking in terms of processes and how data is transformed into something useful. The purpose ov Visualist, is to allow you to *visualize your backlog*.

So what kind of processes are involved in visualizing your backlog? One of the ways a backlog can be visualized is as a story map. That is our first process for Visualist, story mapping. 

We are a building a process, not a set of objects. We can think of *story mapping* as a process a Product Manager engages in, so let's call that our first application in our Visualist application tree.

```
visualist develop % cd apps
apps develop % mix new storymapping --module Visualist.StoryMapping
* creating README.md
* creating .gitignore
* creating mix.exs
* creating config
* creating config/config.exs
* creating lib
* creating lib/storymapping.ex
* creating test
* creating test/test_helper.exs
* creating test/storymapping_test.exs

Your Mix project was created successfully.
You can use "mix" to compile it, test it, and more:

    cd storymapping
    mix test

Run "mix help" for more commands.
```

```
apps develop % ls -al
total 0
drwxr-xr-x   4 jszodfridt  staff  136 Aug 12 16:37 .
drwxr-xr-x  13 jszodfridt  staff  442 Aug 12 15:52 ..
drwxr-xr-x   8 jszodfridt  staff  272 Aug 12 16:37 storymapping
drwxr-xr-x  10 jszodfridt  staff  340 Aug 12 15:52 web
```

An **appication** is an **OTP** construct that can have its own child processes that can be started, stopped, and supervised as complete unit.

## Story Mapping

What does a Product Manager do while they are story mapping?

- Starts a mapping session as they browse their available projects
- They select a project they would like to map
- They browse the available mapping templates, selecting and removing them from their cart until they decide which templete they want to use
- They finalize their selection and see the result of their project visualized per the template they have selected
  

