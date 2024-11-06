---
date: 2024-03-21T13:07:10+03:00
description: "How to upgrade Laravel 7 project to Laravel 8"
featured_image: "/images/laravel8.jpg"
images: ["/images/laravel8.jpg"]
tags: ["Laravel","PHP"]
categories: "Programming"
title: "Steps to upgrade Laravel 7 project to Laravel 8"
---

A few years ago I had an old Laravel project that I built back in 2019. Back then I was still a junior developer
and at that time I had no plans to host it. Fast forward to March 2024 I decided to host it in Heroku which 
I detailed in the last article <Add link here>. 

One of my reasons for this post was to give a guide to help make the 
Laravel version upgrade experience as less time consuming, and straightforward as possible. 

Before the deployment process l first skimmed through the docs and noticed that Heroku ended support for php 7 and this project runs on php 7.3. Easy I could just update the project dependencies by running
this command below
```shell 
$ composer update
``` 
and problem solved but here’s the problem a lot of these dependencies require a minimum dependency version in order for them to install. This can be solved by 
running 
```shell
$ composer update  —ignore-platform-reqs
```
However, this is a careless move as it can break the whole project. Below are the steps on how I carefully upgraded the project to Laravel 8. Make sure the `php version 8` is installed in your workstation. You can check which version is installed by running 
```shell 
$ php -v 
```
Open the `composer.json` file and in the `require` section modify the dependencies to match the below listed versions.

```
- php:^8.0
- guzzlehttp/guzzle: ^7.0.1
- laravel/framework: ^8.0
- laravel/passport: ^10.4.2
- phpunit/phpunit: ^9.0
- facade/ignition: ^2.3.6
- nunomaduro/collision: ^5.0
- laravel/ui: ^3.0
```
After that open your terminal in your project root and run;

```shell
$ composer update 
```
You might encounter some errors on terminal and so I’d advise you to search the package on [packagist](http://packagist.org) or look for it’s website to check which dependency version the package requires and modify accordingly.

There are new changes and styles introduced in Laravel 8. Follow these steps and modify accordingly.

### Seeders

Rename the `database/seeds` directory to `database/seeders`. Now open each seeder class and add a namespace on top of the line like this

```php
<?php
    
 namespace Database\Seeders;
```
### Factories

Next in factories open each factory class and add this  line

```php
<?php

 namespace Database\Factories;
```
### Auto load seeder classes and factory clssses**

Open your composer file and modify the section `autoload` to match this one below.

```json
{ 
  ...,
  "autoload": {
      "psr-4": {
        "App\\": "app/",
        "Database\\Factories\\": "database/factories/",
        "Database\\Seeders\\": "database/seeders/"
      }
  }
}
```

### Routing

Open the `RouteServiceProvider.php` and modify it to reflect the standard 
Laravel 8 [RouteServiceProvider.php](https://github.com/laravel/laravel/blob/v8.1.0/app/Providers/RouteServiceProvider.php). Next update the routes in web.php and api.php files 
to match this style below;

```php
Route::post(‘register’[RegisterController::class,‘register’])→name(‘register’);
```

That’s it !