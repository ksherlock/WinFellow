#ifndef FHFILE_H
#define FHFILE_H

#define FHFILE_MAX_DEVICES 20

typedef enum {
  FHFILE_NONE = 0,
  FHFILE_HDF = 1
} fhfile_status;

typedef struct {
  STR filename[256]; /* Config settings from here and down */
  BOOLE readonly_original;
  ULO bytespersector_original;
  ULO sectorspertrack;
  ULO reservedblocks_original;
  ULO surfaces;
  ULO tracks;            /* From here and down, used by the driver */
  BOOLE readonly;
  ULO bytespersector;
  ULO reservedblocks;
  fhfile_status status;
  FILE *F;
  ULO size;
  bool hasRigidDiskBlock;
  ULO lowCylinder;
  ULO highCylinder;
} fhfile_dev;

extern void fhfileDo(ULO data);

extern void fhfileSetEnabled(BOOLE enabled);
extern BOOLE fhfileGetEnabled(void);
extern void fhfileSetHardfile(fhfile_dev hardfile, ULO index);
extern BOOLE fhfileCompareHardfile(fhfile_dev hardfile, ULO index);
extern BOOLE fhfileRemoveHardfile(ULO index);
extern BOOLE fhfileCreate(fhfile_dev hfile);


extern void fhfileClear(void);
extern void fhfileHardReset(void);
extern void fhfileStartup(void);
extern void fhfileShutdown(void);

#endif
