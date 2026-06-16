page 50988 "Admin No. Setup"
{
    // version TL2.0

    CardPageID = "Admin No. Card Setup";
    PageType = List;
    SourceTable = "Admin Numbering Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Chassis No"; Rec."Chassis No")
                {
                    ApplicationArea = All;
                }
                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field(Mileage; Rec.Mileage)
                {
                    ApplicationArea = All;
                }
                field("Boardroom Name"; Rec."Boardroom Name")
                {
                    ApplicationArea = All;
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
                }
                field(Agenda; Rec.Agenda)
                {
                    ApplicationArea = All;
                }
                field("HOD File Path"; Rec."HOD File Path")
                {
                    ApplicationArea = All;
                }
                field("Approval Remarks"; Rec."Approval Remarks")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Approver Email"; Rec."Approver Email")
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

