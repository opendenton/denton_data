CREATE TABLE denton_housing (
  year integer,
  total_housing_units integer,
  vacant_housing_units integer,
  occupied_housing_units integer,
  owner_occupied integer,
  median_gross_rent integer,
  renter_occupied integer
);

CREATE TABLE well_inspection (
  SiteType text,
  FeatureID text,
  TrakITID text,
  PropertyID text,
  SiteAddres text,
  Operator text,
  Descriptio text,
  WellID text,
  Status text,
  Site text,
  RRCID text,
  PlatID text,
  PlatDate text, /* date */
  AmendedPla text,
  AmendedP_1 text, /* date */
  RoadDmgFee text,
  FeePaidDat text, /* date */
  InvoiceSta text,
  InvoiceS_1 text, /* date */
  RRCPermit text,
  RRCPermitD text, /* date */
  CasingDate text, /* date */
  SpudCompDa text, /* date */
  PlugDate text, /* date */
  GasWellLocation text,
  ZoningDistrict text,
  ZoningCase text,
  LastInspectionDate text,  /*date*/
  FullName text,
  OBJECTID integer
);
