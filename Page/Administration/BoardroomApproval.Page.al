page 50991 "Boardroom Approval"
{
    // version TL2.0

    PageType = List;
    PromotedActionCategories = 'Details,Approval';
    SourceTable = "Booking Process";
    SourceTableView = WHERE(Status = CONST(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Boardroom Name"; Rec."Boardroom Name")
                {
                    ApplicationArea = All;

                }
                field("Booking Time"; Rec."Booking Time")
                {
                    ApplicationArea = All;

                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;

                }
                field(Resources; Rec.Resources)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("Approval Remarks"; Rec."Approval Remarks")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
                field(User; Rec.User)
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
            action("Approve Boardroom Allocation")
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.ApproveBoardroomAllocation(xRec);
                    CurrPage.CLOSE;
                end;
            }
            action("Cancel Boardroom Allocation")
            {
                ApplicationArea = All;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.RejectBoardroomAllocation(Rec);
                end;
            }
            action("Boardroom Booking Report")
            {
                ApplicationArea = All;
                Image = BOMRegisters;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.PreviewBoardroomReport(Rec);
                end;
            }
            action("Reallocate Boardroom")
            {
                ApplicationArea = All;
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.ReallocateBoardroom(Rec);
                end;
            }
            action("Booking Details")
            {
                ApplicationArea = All;
                Image = Design;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin

                    "Booking Process".SETRANGE("No.", Rec."No.");
                    IF "Booking Process".FIND('-') THEN BEGIN
                        PAGE.RUN(50992, "Booking Process");
                    END;
                end;
            }
        }
    }

    var
        CurrentUser: Record "User Setup";
        "Booking Process": Record "Booking Process";
        "Boardroom Booking": Record "Booking Process";
        RegistryManagement: Codeunit "Registry Management2";
}

