Feature: Renaming images
  In order to better handle lots of images
  As someone, who wants to keep track of the photos
  I want to be able to rename all images in a given folder chronologically

  Scenario: Renaming images
    Given I have a folder with the following images
      | name        | exif date        |
      | bar.jpg     | 2015-12-01 16:31 |
      | foo.JPG     | 2015-12-01 16:30 |
      | baz 2.jpg   | 2015-11-30 10:00 |
    When I invoke the renamer in that directory
    Then listing the content of the folder should yield the following result
      """
      2015-11-30-1000_image_001.jpg
      2015-12-01-1630_image_002.jpg
      2015-12-01-1631_image_003.jpg
      """

  Scenario: Renaming live images
    Given I have a folder with the following images
      | name          | exif date        |
      | IMG_2882.JPG  | 2015-12-01 16:30 |
      | IMG_2882.MOV  | 2015-12-01 16:30 |
      | IMG_2883.JPG  | 2015-12-01 16:32 |
      | IMG_2883.MOV  | 2015-12-01 16:32 |
      | IMG_2885.JPG  | 2015-12-01 16:52 |
    When I invoke the renamer in that directory
    Then listing the content of the folder should yield the following result
      """
      2015-12-01-1630_image_001.jpg
      2015-12-01-1630_image_001.mov
      2015-12-01-1632_image_002.jpg
      2015-12-01-1632_image_002.mov
      2015-12-01-1652_image_003.jpg
      """

