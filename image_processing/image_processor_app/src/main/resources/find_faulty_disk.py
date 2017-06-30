import os
import argparse
import cv2
import numpy as np
import time
import json

#frame = None

# returns red and green color LED position
#tracks color on intensity thresholded spots
def getKey(item):
    return item[0]

def getKey1(item):
    return item[1]

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
            

    # remove multiple points around same coordinate
    # clear nearby x'es

    return filteredCordinates
  
  

def getAmberLed(hsvThresholdedImage, args):
    # Hue Range for Amber
    lowerAmberHue = np.array([16, 255, 185])
    upperAmberHue = np.array([22, 255, 255])
    AmberMask = cv2.inRange(hsvThresholdedImage, lowerAmberHue, upperAmberHue)

    #Blurs an image using a Gaussian filter
    amberHueThresholdedImage = cv2.GaussianBlur(AmberMask, (9, 9), 2, 2)

    #if args.output_dir:
     #   result_image_path = os.path.join(args.output_dir, "amber_hue_image.jpg")
      #  cv2.imwrite(result_image_path, amberHueThresholdedImage)

    #find contours in the amber hue image formed
    amberContours = cv2.findContours(amberHueThresholdedImage.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]

    coordinates = []
    
    for i in list(amberContours):
        M = cv2.moments(i)

        amberLEDPos = int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"])

        coordinates.append(amberLEDPos)
        #if (first==2):
#        cv2.circle(image,greenLEDPos,10,(200,0,0),5)
        #first=first+1

    return coordinates    


def find_DAEDisk(coordinates, dae, yrange):

    remaining_coordinates = []
    i = 0
    di = 1
    while i < len(coordinates):
        if i == 0:
            dae.append(coordinates[i])    
        elif (abs(coordinates[i][1] - dae[0][1]) < (yrange/4)):
            dae.append(coordinates[i])

            di += 1
       #     i += 1
        else:
            remaining_coordinates.append(coordinates[i])
        i += 1
    return remaining_coordinates 

    
    

            

#main loop
def main():

    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument("-i", "--image_path", dest = 'image_path', required = True)
    parser.add_argument("-o", "--output_dir", dest = 'output_dir', required = False)
    
    args = parser.parse_args()

    # Load image
    image = cv2.imread(args.image_path)

    #Output image
    out_image = args.image_path.split("/")[-1].split(".")[0] + "_processed.jpg"
    
    #Output response
    out_response = args.image_path.split("/")[-1].split(".")[0] + "_response.json"

    frame = cv2.medianBlur(image,3)
  #  if args.output_dir:
   #     result_image_path = os.path.join(args.output_dir, "blur_image.jpg")
    #    cv2.imwrite(result_image_path, frame)

    greenLEDPos = (-1,-1)

    #convert color from BGR to HSV
    hsvThresholdedImage = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    amberCoordinates = getAmberLed(hsvThresholdedImage, args)

    #Hue Range for Green
    lowerGreenHue = np.array([34, 100, 100])
    upperGreenHue = np.array([54, 255, 255])
    greenMask = cv2.inRange(hsvThresholdedImage, lowerGreenHue, upperGreenHue)

    #Blurs an image using a Gaussian filter
    greenHueThresholdedImage = cv2.GaussianBlur(greenMask, (9, 9), 2, 2)

   # if args.output_dir:
    #    result_image_path = os.path.join(args.output_dir, "green_hue_image.jpg")
    #    cv2.imwrite(result_image_path, greenHueThresholdedImage)

    #find contours in the green hue image formed
    greenContours = cv2.findContours(greenHueThresholdedImage.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]

    coordinates = []

    for i in list(greenContours):
        M = cv2.moments(i)
        greenLEDPos = int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"])
        coordinates.append(greenLEDPos)


    # logic to sort out all coordinates
    coordinates = sorted(coordinates, key=getKey)

    maxy=0
    miny=coordinates[0][1]

    #find difference between max y and min y and divide that by n-1, n is no of disk rows
    for i in coordinates:
        if (i[1] >= maxy):
            maxy = i[1]
        if (i[1] <= miny):
            miny = i[1]






# here n is 2 doe disk rows, so I have 2 arrays for coordinates
    noOfEnclosures = 2

    if (noOfEnclosures != 1):
        yrange = (maxy - miny)/(noOfEnclosures - 1)
    else:
        yrange = (maxy - miny)
        yrange = yrange
  
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

            

  

    loop_cnt = 0
    while loop_cnt < len(nArrayDisk):
        nArrayDisk[loop_cnt] = removeNoise(nArrayDisk[loop_cnt])
        loop_cnt = loop_cnt + 1


    finalGlobaldae = []
    finaldae0 = []
    finaldae1 = []
    finaldae2 = []

    finaldae = []
    
    finalGlobaldae.append(finaldae0)
    finalGlobaldae.append(finaldae1)
    finalGlobaldae.append(finaldae2)
    index = 0
    while index < noOfEnclosures:
        finaldae.append(finalGlobaldae[index])
        index = index + 1
    

    loop_cnt = 0
    while loop_cnt < len(nArrayDisk):
        dae1 = nArrayDisk[loop_cnt]
        finaldae1 = finaldae[loop_cnt]
    # finalize the dae lists incase if there are empty disks in there
        if len(nArrayDisk[0]) == 15:
            print "nothing to do"
        else:
    #       dae1 = nArrayDisk[0]
    #       finaldae1 = finalGlobaldae[0]
            i = 0
            index = 0
            counter = 0
            daecounter = 0
            while counter < 15:

                if (counter == 0):
                    finaldae1.append(dae1[daecounter])
                    daecounter=daecounter+1
                
                else:

                    if ((finaldae1[counter - 1][0]) == 0):
                        zerocnt = 0
                        zeroindex = counter - 1
                        while ((finaldae1[zeroindex][0]) == 0):
                            zeroindex = zeroindex - 1
                            zerocnt = zerocnt + 1
                        zerocnt = zerocnt + 1   
                    # compare finaldae1(zeroindex) with dae1[daecounter][0], using 150 in place of 176, 250 by 240
                        if (daecounter < len(dae1)) and ((finaldae1[zeroindex][0] + (176 * zerocnt)) <= dae1[daecounter][0] <= (finaldae1[zeroindex][0] + (250 * zerocnt))):
                            finaldae1.append(dae1[daecounter])

                            daecounter=daecounter+1
                        else:

                            finaldae1.append([0,0])
                        
                    else:
                        if (daecounter < len(dae1)) and ((finaldae1[counter - 1][0] + (176)) <= dae1[daecounter][0] <= (finaldae1[counter - 1][0] + (250))):
                            finaldae1.append(dae1[daecounter])

                        
                            daecounter=daecounter+1
                        else:

                            finaldae1.append([0,0])

                counter = counter + 1
        loop_cnt = loop_cnt + 1            

                
    finalGlobaldaeOrdered = []

    ycoordlist = []
    loop_cnt = 0
    while loop_cnt < len(finaldae):
        daelist = finaldae[loop_cnt]
        ycoordlist.append(daelist[0])
        loop_cnt = loop_cnt + 1


    sortedYlist = sorted(ycoordlist, key=getKey1)



    loop_cnt = 0
    while loop_cnt < len(sortedYlist):
        loop_cnt2 = 0
        while loop_cnt2 < len(finaldae):
            dae = finaldae[loop_cnt2]
            if (sortedYlist[loop_cnt][0] == dae[0][0]) and (sortedYlist[loop_cnt][1] == dae[0][1]):
                finalGlobaldaeOrdered.append(dae)
                break
            else:
                loop_cnt2 = loop_cnt2 + 1
        loop_cnt = loop_cnt + 1


    
    
    for i in nArrayDisk[0]:
        cv2.circle(image,i,10,(200,0,0),5)
    #    print i
    for i in nArrayDisk[1]:
        cv2.circle(image,i,10,(0,0,255),5)

    if len(nArrayDisk) > 2 :
        for i in nArrayDisk[2]:
            cv2.circle(image,i,10,(0,255,0),5)

    
    

  #  removeNoise(dae1)
    
    validcoordinates = []
    enclDict = {} 
    out_enclList = [] 
    diskList = []
    encl_count_print = 0

    outDict = {}
    
    # Now discard extra amber coordinates which do not fit in any enclosure
    for i in amberCoordinates:
        present = 0
        encl_count = 0
        for n in finalGlobaldaeOrdered:  
        #for n in nArrayDisk:
            # find min x and max x for this enclosure
            minx = n[0]
            maxx = 0
            for m in n:
                if (m[0] < minx) and (m[0] != 0):
                    minx = m[0]
                if m[0] > maxx:
                    maxx = m[0]
            # find min y and max y
            miny = n[0]
            maxy = 0
            for m in n:
                if (m[1] < miny) and (m[1] != 0):
                    miny = m[1]
                if m[1] > maxy:
                    maxy = m[0]

            # now check for coordinate whether it is in range       
            if ((minx <= i[0] <= maxx) and (miny <= i[1] <= maxy)):
                present = 1
                # find it is closer to which

                loop_cnt = 0
                while loop_cnt < len(n):
                    if (i[0] < n[loop_cnt][0]):
                        
                   # else:
                        break;
                    loop_cnt = loop_cnt + 1
                    
                
                diskList.append(loop_cnt - 1)
                enclDict[encl_count] = diskList
                    
                #print "Disk ", loop_cnt - 1, "is faulty in enclosure ",encl_count 

                    
                break
            encl_count = encl_count + 1
            
            if encl_count_print < encl_count:
                encl_count_print = encl_count
                
        if present == 1 :
            validcoordinates.append(i)
            
    #print enclDict, encl_count_print
    #s = "There are " + str(encl_count_print) + " enclosures. \n"  
#    Hardcoding Bus no as 0
    bus = 0
    for key in enclDict.keys():
        #s = s + "Faulty disks in enc " + str(key) + ": " + str(enclDict[key]) + "\n"
        elem = enclDict[key]
        #out_diskList = []
        for i in range(0, len(elem)):
            disk = str(bus) + "_" + str(key-1) + "_" + str(elem[i])
           # out_diskList.append(disk)
            out_enclList.append(disk) 
    
    #print out_enclList    
    pkey = len(enclDict)
    while pkey < encl_count_print:
        #out_diskList = []
        #out_enclList.append(out_diskList) 
        #s = s + "Faulty disks in enc " + str(pkey + 1)+ ": NONE \n"
        pkey += 1      

       
    # find this amber belongs to which to which disk in which dae

    for i in validcoordinates:
        cv2.circle(image,i,10,(0,255,0),5)      
     
        font = cv2.FONT_HERSHEY_SIMPLEX
        cv2.putText(image, 'FAIL', ((i[0]-35),(i[1]-600)), font, 2, (0, 0, 255), 8, cv2.LINE_AA)
        
    if args.output_dir:
        result_image_path = os.path.join(args.output_dir, out_image)
        cv2.imwrite(result_image_path, image)

    s = ""
    for iu in range(0, len(out_enclList)-1):
        s += str(out_enclList[iu]) + "," 
    s += str(out_enclList[-1])

    outDict["response_text"] = s 
    outDict["response_image"] = out_image 
    print outDict
    #outputfile = os.path.join(args.output_dir, out_response)
    outputfile = args.output_dir + "/" + out_response
    
    
    with open(outputfile, 'w') as outfile:
        json.dump(outDict, outfile)

    
    
if __name__ == '__main__':
    main()
