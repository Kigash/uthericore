page 50952 "Registry Setup"
{
    // version TL2.0

    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Registry SetUp";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Return ID"; Rec."Return ID")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Member File Nos."; Rec."Member File Nos.")
                {
                    ApplicationArea = All;
                }
                field("Staff File Nos."; Rec."Staff File Nos.")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Other File Nos."; Rec."Other File Nos.")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Loan File Nos."; Rec."Loan File Nos.")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("File Movement ID"; Rec."File Movement ID")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Files No."; Rec."Files No.")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Transfer ID"; Rec."Transfer ID")
                {
                    ApplicationArea = All;
                }
                field("Max. Files held by a person"; Rec."Max. Files held by a person")
                {
                    ApplicationArea = All;
                }
                field("Registry Email"; Rec."Registry Email")
                {
                    ApplicationArea = All;
                }
            }
            group("File Numbers")
            {
                Caption = 'File Numbers';
                Visible = false;
                field("Branch1 Active"; Rec."Branch1 Active")
                {
                    ApplicationArea = All;
                }
                field("Branch2 Active"; Rec."Branch2 Active")
                {
                    ApplicationArea = All;
                }
                field("Branch3 Active"; Rec."Branch3 Active")
                {
                    ApplicationArea = All;
                }
                field("Branch4 Active"; Rec."Branch4 Active")
                {
                    ApplicationArea = All;
                }
                field("Branch5 Active"; Rec."Branch5 Active")
                {
                    ApplicationArea = All;
                }
                field("Branch6 Active"; Rec."Branch6 Active")
                {
                    ApplicationArea = All;
                }
                field("Branch1 InActive"; Rec."Branch1 InActive")
                {
                    ApplicationArea = All;
                }
                field("Branch2 InActive"; Rec."Branch2 InActive")
                {
                    ApplicationArea = All;
                }
                field("Branch3 InActive"; Rec."Branch3 InActive")
                {
                    ApplicationArea = All;
                }
                field("Branch4 InActive"; Rec."Branch4 InActive")
                {
                    ApplicationArea = All;
                }
                field("Branch5 InActive"; Rec."Branch5 InActive")
                {
                    ApplicationArea = All;
                }
                field("Branch6 InActive"; Rec."Branch6 InActive")
                {
                    ApplicationArea = All;
                }
                field("Branch1 Withdrawn"; Rec."Branch1 Withdrawn")
                {
                    ApplicationArea = All;
                }
                field("Branch2 Withdrawn"; Rec."Branch2 Withdrawn")
                {
                    ApplicationArea = All;
                }
                field("Branch3 Withdrawn"; Rec."Branch3 Withdrawn")
                {
                    ApplicationArea = All;
                }
                field("Branch4 Withdrawn"; Rec."Branch4 Withdrawn")
                {
                    ApplicationArea = All;
                }
                field("Branch5 Withdrawn"; Rec."Branch5 Withdrawn")
                {
                    ApplicationArea = All;
                }
                field("Branch6 Withdrawn"; Rec."Branch6 Withdrawn")
                {
                    ApplicationArea = All;
                }
                field("Branch1 Closed"; Rec."Branch1 Closed")
                {
                    ApplicationArea = All;
                }
                field("Branch2 Closed"; Rec."Branch2 Closed")
                {
                    ApplicationArea = All;
                }
                field("Branch3 Closed"; Rec."Branch3 Closed")
                {
                    ApplicationArea = All;
                }
                field("Branch4 Closed"; Rec."Branch4 Closed")
                {
                    ApplicationArea = All;
                }
                field("Branch5 Closed"; Rec."Branch5 Closed")
                {
                    ApplicationArea = All;
                }
                field("Branch6 Closed"; Rec."Branch6 Closed")
                {
                    ApplicationArea = All;
                }
                field("Branch1 Deceased"; Rec."Branch1 Deceased")
                {
                    ApplicationArea = All;
                }
                field("Branch2 Deceased"; Rec."Branch2 Deceased")
                {
                    ApplicationArea = All;
                }
                field("Branch3 Deceased"; Rec."Branch3 Deceased")
                {
                    ApplicationArea = All;
                }
                field("Branch4 Deceased"; Rec."Branch4 Deceased")
                {
                    ApplicationArea = All;
                }
                field("Branch5 Deceased"; Rec."Branch5 Deceased")
                {
                    ApplicationArea = All;
                }
                field("Branch6 Deceased"; Rec."Branch6 Deceased")
                {
                    ApplicationArea = All;
                }
                field("Branch1 Volume"; Rec."Branch1 Volume")
                {
                    ApplicationArea = All;
                }
                field("Branch2 Volume"; Rec."Branch2 Volume")
                {
                    ApplicationArea = All;
                }
                field("Branch3 Volume"; Rec."Branch3 Volume")
                {
                    ApplicationArea = All;
                }
                field("Branch4 Volume"; Rec."Branch4 Volume")
                {
                    ApplicationArea = All;
                }
                field("Branch5 Volume"; Rec."Branch5 Volume")
                {
                    ApplicationArea = All;
                }
                field("Branch6 Volume"; Rec."Branch6 Volume")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

