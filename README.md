# Java Packager

## DISCLAIMER!

This is a work in progress, and by no means complete at this time.

## JAVA LICENSE

Please read the [Oracle Java License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html)

##  Purpose

This will build java packages for you.

## Prerequisites

  * [Vagrant](http://www.vagrantup.com/)
  * [Oracle Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

## Instructions

`git clone` this project, put the jdk tarbal in the directory, edit the Vagrantfile, and run `vagrant up`

## Settings

  * java.target: see [this](http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version)
  * java.raw: the actual name of the java package in your project dir, the one you got from oracle.
  * vendorname: your company
  * maintainer: your name
