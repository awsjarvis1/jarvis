#!/usr/bin/env python
import os
import argparse
import cv2
import numpy as np
import time

#frame = None

# returns red and green color LED position
#tracks color on intensity thresholded spots
def getKey(item):
    return item[0]

def removeNoise(dae):
    miny = dae[0][1]
    maxy= 0
    filteredCordinates =[]
    for i in dae:
        if miny > i[1]:
            miny = i[1]
        if maxy < i[1]:
            maxy = i[1]
    count = 0
    print "yrange",miny,maxy
    minxdistance = 176
    for i in dae:
        #if miny <= i[1] <= maxy:
            if count == 0:
                filteredCordinates.append(i)
                count=count+1
            if count != 0:
 #               print i[0], dae[count-1][0]
                   #compare current x with previous x
                val = (i[0]-filteredCordinates[count-1][0]) / minxdistance
                if val > 0:
                    filteredCordinates.append(i)
                    count=count+1
   #             print "val",val
            

    # remove multiple points around same coordinate
    # clear nearby x'es

    return filteredCordinates

    
    
def getSilverBox(hsvThresholdedImage, args):
    # Hue Range for Amber
    lowerAmberHue = np.array([0, 0, 105])
    upperAmberHue = np.array([0, 0, 220])
    AmberMask = cv2.inRange(hsvThresholdedImage, lowerAmberHue, upperAmberHue)

    #Blurs an image using a Gaussian filter
    amberHueThresholdedImage = cv2.GaussianBlur(AmberMask, (9, 9), 2, 2)

    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, "silver_hue_image.jpg")
        cv2.imwrite(result_image_path, amberHueThresholdedImage)

def getAmberLed(hsvThresholdedImage, args):
    # Hue Range for Amber
    lowerAmberHue = np.array([16, 255, 185])
    upperAmberHue = np.array([22, 255, 255])
    AmberMask = cv2.inRange(hsvThresholdedImage, lowerAmberHue, upperAmberHue)

    #Blurs an image using a Gaussian filter
    amberHueThresholdedImage = cv2.GaussianBlur(AmberMask, (9, 9), 2, 2)

    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, "amber_hue_image.jpg")
        cv2.imwrite(result_image_path, amberHueThresholdedImage)

    #find contours in the amber hue image formed
    amberContours = cv2.findContours(amberHueThresholdedImage.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]

    coordinates = []
    
    for i in list(amberContours):
        M = cv2.moments(i)
        #print "What's M", M
        amberLEDPos = int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"])
       # print greenLEDPos
        coordinates.append(amberLEDPos)
        #if (first==2):
#        cv2.circle(image,greenLEDPos,10,(200,0,0),5)
        #first=first+1

    return coordinates    


def find_DAEDisk(coordinates, dae, yrange):
 #   print "Coordinates inside find : ", coordinates
    remaining_coordinates = []
    i = 0
    di = 1
    while i < len(coordinates):
        if i == 0:
            dae.append(coordinates[i])    
        elif (abs(coordinates[i][1] - dae[di-1][1]) < (yrange/4)):
            dae.append(coordinates[i])
         #   print i, coordinates[i]
            di += 1
       #     i += 1
        else:
            remaining_coordinates.append(coordinates[i])
        i += 1
    return remaining_coordinates 

    
    

            

#main loop
def main():
    print "hi"
    red_x = []
    red_y = []
    green_x = []
    green_y = []

    
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument("-i", "--image_path", dest = 'image_path', required = True)
    parser.add_argument("-o", "--output_dir", dest = 'output_dir', required = False)
    
    args = parser.parse_args()

    # Load image
    image = cv2.imread(args.image_path)


    frame = cv2.medianBlur(image,3)
    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, "blur_image.jpg")
        cv2.imwrite(result_image_path, frame)

    greenLEDPos = (-1,-1)

    #convert color from BGR to HSV
    hsvThresholdedImage = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    amberCoordinates = getAmberLed(hsvThresholdedImage, args)

    getSilverBox(hsvThresholdedImage, args)
    
    #Hue Range for Green
    lowerGreenHue = np.array([34, 100, 100])
    upperGreenHue = np.array([54, 255, 255])
    greenMask = cv2.inRange(hsvThresholdedImage, lowerGreenHue, upperGreenHue)

    #Blurs an image using a Gaussian filter
    greenHueThresholdedImage = cv2.GaussianBlur(greenMask, (9, 9), 2, 2)

    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, "green_hue_image.jpg")
        cv2.imwrite(result_image_path, greenHueThresholdedImage)

    #find contours in the green hue image formed
    greenContours = cv2.findContours(greenHueThresholdedImage.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]
    # only proceed if at least one contour was found
    if len(greenContours) > 0:
        # find the largest contour in the mask, then use it to compute the minimum enclosing circle and centroid
        maxContour = max(greenContours, key=cv2.contourArea)
        M = cv2.moments(maxContour)
        greenLEDPos = int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"])

    green_x.append(greenLEDPos[0])
    green_y.append(greenLEDPos[1])

    coordinates = []
    first =1;

    for i in list(greenContours):
        
        M = cv2.moments(i)
        greenLEDPos = int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"])
        coordinates.append(greenLEDPos)
      
    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, "final_image.jpg")
        cv2.imwrite(result_image_path, image)

# logic to sort out all coordinates
    coordinates = sorted(coordinates, key=getKey)

    print "Global list:", coordinates

    maxy=0
    miny=coordinates[0][1]

#find difference between max y and min y and divide that by n-1, n is nor of disk rows
    for i in coordinates:
        if (i[1] >= maxy):
            maxy = i[1]
        if (i[1] <= miny):
            miny = i[1]
    print "max y ", maxy
    print "min y", miny        




# here n is 2 doe disk rows, so I have 2 arrays for coordinates
    noOfEnclosures = 3

    if (noOfEnclosures != 1):
        yrange = (maxy - miny)/(noOfEnclosures - 1)
    else:
        yrange = (maxy - miny)
        yrange = yrange/(noOfEnclosures - 1)
  
# take smallest x from the sorted list and try to place y in one of the two lists
    count = 1    
    index = 0
    nArrayDisk = []

    dae1 = []
    dae2 = []
    dae3 = []
    dae4 = []
    dae5 = []
    
    nArrayDiskGlobal = []
    nArrayDiskGlobal.append(dae1)
    nArrayDiskGlobal.append(dae2)
    nArrayDiskGlobal.append(dae3)
    nArrayDiskGlobal.append(dae4)
    nArrayDiskGlobal.append(dae5)
    
    while index < noOfEnclosures:
        nArrayDisk.append(nArrayDiskGlobal[index])
        index = index + 1
#    nArrayDisk.append(dae2)

    if (noOfEnclosures != 1): 
        for n in nArrayDisk:
            coordinates = find_DAEDisk(coordinates, n, yrange)
    else:
        nArrayDisk[0] = coordinates

            
    print "dae1", nArrayDisk[0]
    print "dae2", nArrayDisk[1]
    print "dae3", nArrayDisk[2]

    for i in nArrayDisk[0]:
        cv2.circle(image,i,10,(0,0,255),5)

    for i in nArrayDisk[0]:
        cv2.circle(image,i,10,(0,0,255),5)

    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, "final_image_dae2.jpg")
        cv2.imwrite(result_image_path, image)
    
    print "amber", amberCoordinates

    nArrayDisk[0] = removeNoise(nArrayDisk[0])
    nArrayDisk[1] = removeNoise(nArrayDisk[1])

    
    finaldae1 = []
    dae1 = nArrayDisk[0]
    dae2 = nArrayDisk[1]
    print "DAE1 :", dae1
    print "DAE2 :", dae2
    print "nArrayDisk[0]", nArrayDisk[0]

    
    # finalize the dae lists incase if there are empty disks in there
    if len(nArrayDisk[0]) == 15:
        print "nothing to do"
    else:
        i = 0
        index = 0
        counter = 0
        daecounter = 0
        while counter < 15:
            print daecounter, counter
            if (counter == 0):
                finaldae1.append(dae1[daecounter])
                daecounter=daecounter+1
                
            else:
                # fill in the position by using dae1 if x val fall sin range with the prev x value else add [0][0]
                # pick next value from dae1 and check whether it fits in for next slot
       #         print "finaldae1[0][0] + (counter * 176)", finaldae1[0][0] + (counter * 176)
      #          print "dae1[daecounter]",dae1[daecounter][0]
                #if (daecounter < len(dae1)) and ((finaldae1[0][0] + (counter * 176)) <= dae1[daecounter][0] <= (finaldae1[0][0] + (counter * 250))):
                print "finaldae1[counter - 1][0]", finaldae1[counter - 1][0]
                if ((finaldae1[counter - 1][0]) == 0):
                    zerocnt = 0
                    zeroindex = counter - 1
                    while ((finaldae1[zeroindex][0]) == 0):
                        zeroindex = zeroindex - 1
                        zerocnt = zerocnt + 1
                    zerocnt = zerocnt + 1   
                    # compare finaldae1(zeroindex) with dae1[daecounter][0]
                    if (daecounter < len(dae1)) and ((finaldae1[zeroindex][0] + (176 * zerocnt)) <= dae1[daecounter][0] <= (finaldae1[zeroindex][0] + (250 * zerocnt))):
                        finaldae1.append(dae1[daecounter])
                        print "zeroed case dae1[daecounter][0]",dae1[daecounter][0]
                        daecounter=daecounter+1
                    else:
                        print "case1"
                        finaldae1.append([0,0])
                        
                else:
                    if (daecounter < len(dae1)) and ((finaldae1[counter - 1][0] + (176)) <= dae1[daecounter][0] <= (finaldae1[counter - 1][0] + (250))):
                        finaldae1.append(dae1[daecounter])
                        print "dae1[daecounter][0]",dae1[daecounter][0]
                        
                        daecounter=daecounter+1
                    else:
                        print "case 2"
                        finaldae1.append([0,0])

            counter = counter + 1

    print "finaldae1", finaldae1
                
    
    for i in dae1:
        cv2.circle(image,i,10,(200,0,0),5)
    #    print i
    for i in dae2:
        cv2.circle(image,i,10,(0,0,255),5)

    
    
    

  #  removeNoise(dae1)
    
    validcoordinates = []
    
    # Now discard extra amber coordinates which do not fit in any enclosure
    for i in amberCoordinates:
        present = 0
        for n in nArrayDisk:
            # find min x and max x for this enclosure
            minx = n[0]
            maxx = 0
            for m in n:
                if m[0] < minx:
                    minx = m[0]
                if m[0] > maxx:
                    maxx = m[0]
            # find min y and max y
            miny = n[0]
            maxy = 0
            for m in n:
                if m[1] < miny:
                    miny = m[1]
                if m[1] > maxy:
                    maxy = m[0]

            # now check for coordinate whether it is in range       
            if ((minx <= i[0] <= maxx) and (miny <= i[1] <= maxy)):
                present = 1
                # find it is closer to which 
                break
        if present == 1 :
            validcoordinates.append(i)

    # find this amber belongs to which to which disk in which dae

    for i in validcoordinates:
        cv2.circle(image,i,10,(0,255,0),5)
        
    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, "final_image_dae1.jpg")
        cv2.imwrite(result_image_path, image)

    
    print "valid amber", validcoordinates
    print "yrange",yrange
 #   cv2.imshow("plank", image)
 #   cv2.waitKey()

        #key = cv2.waitKey(1) & 0xFF
        # if the 'q' key is pressed, break from the loop
        #if key == ord("q"):
        #    break
    print " hi"
    # close all open windows
 #   cv2.destroyAllWindows()

 #   return args["posFileName"], red_x, red_y, green_x, green_y, width, height

if __name__ == '__main__':
    main()
