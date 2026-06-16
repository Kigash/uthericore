page 50445 "Employee Movement"
{
    // version TL2.0

    Caption = 'Employee Movement';
    PageType = Card;
    SourceTable = 50229;
    DataCaptionFields = "Employee Name", Type;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec."Current Branch")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Current Department")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Current Job Tiltle")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec."Current Grade")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group("Transfer Details")
            {
                Caption = 'Transfer Details';
                field("New Branch Code"; Rec."New Branch Code")
                {
                    ApplicationArea = All;
                }
                field("New Branch Name"; Rec."New Branch Name")
                {
                    ApplicationArea = All;
                }
                field("New Department Code"; Rec."New Department Code")
                {
                    ApplicationArea = All;
                }
                field("New Department Name"; Rec."New Department Name")
                {
                    ApplicationArea = All;
                }
                field("New Job Title"; Rec."New Job Title")
                {
                    ApplicationArea = All;
                }
                field("New Grade"; Rec."New Grade")
                {
                    ApplicationArea = All;
                }
                field("New Salary"; Rec."New Salary")
                {
                    ApplicationArea = All;
                }
            }
            group(Audit)
            {
                Caption = 'Audit';
                Editable = false;
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                }
                field("Posted Time"; Rec."Posted Time")
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
            action(Post)
            {
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeePost;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text000) THEN BEGIN
                        HRManagement.PostStaffMovement(Rec);
                    END;
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.Type := Rec.Type::Transfer;
    end;

    trigger OnOpenPage();
    begin
        Visibility;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec.Status = Rec.Status::Posted then begin
            Error('This record cannot be deleted!');
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Visibility();
    end;

    var
        Text000: Label 'Are you sure you want to post the staff transfer?';
        HRManagement: Codeunit 50050;
        SeePost: Boolean;

    local procedure Visibility();
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            SeePost := TRUE;
            CurrPage.EDITABLE(TRUE);
        END ELSE BEGIN
            SeePost := FALSE;
            CurrPage.EDITABLE(FALSE);
        END;
    end;
}
