page 51013 "Returned Vehicle"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Vehicle Booking";

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
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Caption = 'Returned By';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Available Car"; Rec."Available Car")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle Number Plate';
                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Return Date"; Rec."Vehicle Return Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Return time"; Rec."Vehicle Return time")
                {
                    ApplicationArea = All;
                }
                field("Return Vehicle"; Rec."Return Vehicle")
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
            action("Vehicle Return")
            {
                ApplicationArea = all;
                Caption = 'Vehicle Return';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin

                    AdminManagement.ReturnVehicle(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        vehicle: Record "Vehicle Register";
        //CurrentUser: Record "91";
        Notices: Record Notice;
        //Employee: Record "5200";
        HODEmail: Text[80];
        // smtpcu: Codeunit "400";
        bdDialog: Dialog;
        //smtpsetup: Record "409";
        mailheader: Text;
        mailbody: Text;
        //depemails: Record "349";
        AdminManagement: Codeunit "Admin Management";
}

