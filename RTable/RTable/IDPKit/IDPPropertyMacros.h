//
//  IDPPropertyMacros.h
//  PatternShots
//
//  Created by Oleksa 'trimm' Korin on 2/20/13.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#define IDPNonatomicRetainPropertySynthesize(ivar, newObject) \
		do { \
			if (ivar != newObject) { \
				[ivar release]; \
				ivar = [newObject retain]; \
			} \
		} while(0)

#define IDPNonatomicCopyPropertySynthesize(ivar, newObject) \
		do { \
			if (ivar != newObject) { \
				[ivar release]; \
				ivar = [newObject copy]; \
			} \
		} while(0)

#define IDPNonatomicAssignPropertySynthesize(ivar, newObject) \
		do { \
			ivar = newObject; \
		} while(0)

#define IDPNonatomicRetainPropertySynthesizeWithObserver(ivar, newObject) \
		do { \
			if (ivar != newObject) { \
				[ivar removeObserver:self]; \
				[ivar release]; \
				ivar = [newObject retain]; \
				[ivar addObserver:self]; \
			} \
		} while(0)
