page 50436 "Leave Journal"
{
    // version TL2.0

    PageType = List;
    SourceTable = 50224;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No"; Rec."Document No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {

                    trigger OnValidate();
                    begin
                        Employee.RESET;
                        Employee.SETRANGE("No.", Rec."Employee No.");
                        IF Employee.FIND('-') THEN BEGIN
                            Rec."Employee Name" := Employee."Search Name";
                        END;
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Leave Data")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    HRManagement.PostLeaveJournal(Rec);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."Leave Type" := 'ANNUAL';
    end;

    var
        SMTP: Codeunit "SMTP Mail";
        LeaveLedgerEntry: Record 50209;
        LeaveLedger: Record 50209;
        LastNumber: Integer;
        HRJournalLine: Record 50209;
        LeaveJournal: Record 50224;
        Employee: Record 5200;

        HRSetup: Record 5218;
        maiheader: Text;
        mailbody: Text;
        User: Record 91;
        Selected: Integer;
        HRManagement: Codeunit 50050;
}
