# ModernInno (c) 2018 Robin Lobel
Modern look for Inno Setup, banner based.

Usage
-----

In your project, add the following lines:

    #include "moderninno.iss"
    [Setup]  
    WizardSmallImageFile=PathToMyBannerImage

The layout is automatically resized based on the size of your banner image.  
All page will use this layout, including the Welcome and Finished pages.

![ModernInno Example](moderninno.png)
