page 50989 "Admin No. Card Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Admin Numbering Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";

                }
                field("Chassis No"; Rec."Chassis No")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field(Mileage; Rec.Mileage)
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Boardroom Name"; Rec."Boardroom Name")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field(Agenda; Rec.Agenda)
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("HOD File Path"; Rec."HOD File Path")
                {
                    ApplicationArea = All;
                }
                field("Approval Remarks"; Rec."Approval Remarks")
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    LookupPageId = "No. Series";
                }
                field("Approver Email"; Rec."Approver Email")
                {
                    ApplicationArea = All;
                }
                field("Notice File"; Rec."Notice File")
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

