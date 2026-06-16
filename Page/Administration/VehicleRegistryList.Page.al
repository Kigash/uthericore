page 51000 "Vehicle Registry list"
{
    // version TL2.0

    CardPageID = "Vehicle Register card";
    PageType = List;
    SourceTable = "Vehicle Register";

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
                field("Fixed Asset Car No."; Rec."Fixed Asset Car No.")
                {
                    ApplicationArea = All;
                }
                field("Responsible Driver"; Rec."Responsible Driver")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Insured; Rec.Insured)
                {
                    ApplicationArea = All;
                }
                field("Date of Insurance"; Rec."Date of Insurance")
                {
                    ApplicationArea = All;
                }
                field(Months; Rec.Months)
                {
                    ApplicationArea = All;
                }
                field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Number Plate"; Rec."Number Plate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chassis No"; Rec."Chassis No")
                {
                    ApplicationArea = All;
                }
                field("Body Type"; Rec."Body Type")
                {
                    ApplicationArea = All;
                }
                field(Colour; Rec.Colour)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Engine No"; Rec."Engine No")
                {
                    ApplicationArea = All;
                }
                field(YOM; Rec.YOM)
                {
                    ApplicationArea = All;
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Booked; Rec.Booked)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Vehicle register")
            {
                ApplicationArea = all;
                Caption = 'Print Vehicle Register';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    CLEAR("Vehicle Register1");
                    "Vehicle Register".RESET;
                    "Vehicle Register".SETRANGE("No.", Rec."No.");
                    IF "Vehicle Register".FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50564, TRUE, FALSE, "Vehicle Register");
                    END;
                end;
            }
            action("Check Insurance Expiry")
            {
                Image = Insurance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    AdminManagement.CheckInsuranceExpirydate(Rec);
                    //CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        "Vehicle Register1": Record "Vehicle Register";
        "Vehicle Register": Record "Vehicle Register";
        //CurrentUser : Record "91";
        // Mail : Codeunit "397";
        //Employee : Record "5200";
        HODEmail: Text[80];
        //smtpcu : Codeunit "400";
        bdDialog: Dialog;
        //smtpsetup : Record "409";
        mailheader: Text;
        mailbody: Text;
        AdminManagement: Codeunit "Admin Management";
}

