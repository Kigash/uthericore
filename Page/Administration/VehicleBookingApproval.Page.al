page 50180 "Vehicle Booking Approval"
{
    // version TL2.0

    Editable = true;
    PageType = List;
    SourceTable = "Vehicle Booking";
    SourceTableView = WHERE(Status = CONST(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Period of Use"; Rec."Period of Use")
                {
                    ApplicationArea = All;
                }
                field("Booking Time"; Rec."Booking Time")
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
                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;
                }
                field(Booked; Rec.Booked)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Approval Remarks"; Rec."Approval Remarks")
                {
                    ApplicationArea = All;
                }
                field("Driver Required ?"; Rec."Driver Required ?")
                {
                    ApplicationArea = All;
                }
                field("Assign Driver"; Rec."Assign Driver")
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
            action("Approve Vehicle Booking")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    AdminManagement.ApproveVehicleBooking(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Reject Vehicle Booking")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    AdminManagement.RejectVehicleBooking(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("View Booking  Details")
            {
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin



                    vehiclebooking.RESET;
                    vehiclebooking.SETRANGE("No.", Rec."No.");
                    IF vehiclebooking.FIND('-') THEN BEGIN
                        PAGE.RUN(51005, vehiclebooking);
                    END;
                end;
            }
        }
    }

    var
        //CurrentUser : Record "91";
        //Mail : Codeunit "397";
        //Employee : Record "5200";
        HODEmail: Text[80];
        //smtpcu : Codeunit "400";
        bdDialog: Dialog;
        //smtpsetup : Record "409";
        mailheader: Text;
        mailbody: Text;
        vehiclebooking: Record "Vehicle Booking";
        //depemails : Record "349";
        AdminManagement: Codeunit "Admin Management";
}

