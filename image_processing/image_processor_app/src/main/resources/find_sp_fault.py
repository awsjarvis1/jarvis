import cv2
import os
import numpy as np
import argparse
import json


template_path = os.environ.get('WORKSPACE_IMAGE')+'/image_processor_app/src/main/resources/template.jpg'

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument("-i", "--image_path", dest = 'image_path', required = True)
parser.add_argument("-o", "--output_dir", dest = 'output_dir', required = False)
    
args = parser.parse_args()

    # Load image
img = cv2.imread(args.image_path,0)

color_img = cv2.imread(args.image_path)

#Output image
out_image = args.image_path.split("/")[-1].split(".")[0] + "_processed.jpg"

#Output response
out_response = args.image_path.split("/")[-1].split(".")[0] + "_response.json"

#gray_image = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)


#img = cv2.imread('messi5.jpg',0)
img2 = img.copy()

template = cv2.imread(template_path,0)
w, h = template.shape[::-1]

#print "width", w, "height",h

# All the 6 methods for comparison in a list
methods = ['cv2.TM_CCOEFF', 'cv2.TM_CCOEFF_NORMED', 'cv2.TM_CCORR',
            'cv2.TM_CCORR_NORMED', 'cv2.TM_SQDIFF', 'cv2.TM_SQDIFF_NORMED']


img = img2.copy()


    # Apply template Matching
res = cv2.matchTemplate(img,template,cv2.TM_CCOEFF_NORMED)
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(res)

    # If the method is TM_SQDIFF or TM_SQDIFF_NORMED, take minimum
top_left = max_loc

#print "top_left",top_left
bottom_right = (top_left[0] + w, top_left[1] + h)

cv2.rectangle(color_img,top_left, bottom_right, 255, 2)

#cv2.circle(color_img,top_left,10,(0,0,255),5)

pixel_x = top_left[0]+ 52   # x coordinate
pixel_y = top_left[1]+ 18   # y coordinate

coord = (pixel_x, pixel_y)

cv2.circle(color_img,coord,10,(0,0,255),5)


outDict = {}

imag = cv2.imread(args.image_path)
color = imag[pixel_y][pixel_x]
#print "color pixel :", color[0], color[1], color[2]
blue  = color[0]
green = color[1]
red   = color[2]
s = "No Fault !!"
# Check for blue Color
if blue > 245 and green > 245 and red < 240:
#    print "BLUE TRIANGLE DETECTED"
    s = "CPU is DEGRADED !!"
if blue < 240 and green > 220 and red > 250:
#    print "AMBER TRIANGLE DETECTED"
    s = "CPU is FAULTED !!" 


outDict["response_text"] = s
outDict["response_image"] = out_image
print outDict


if args.output_dir:
    result_image_path = os.path.join(args.output_dir, out_image)
    cv2.imwrite(result_image_path, color_img)


outputfile = args.output_dir + "/" + out_response

with open(outputfile, 'w') as outfile:
    json.dump(outDict, outfile)
        
