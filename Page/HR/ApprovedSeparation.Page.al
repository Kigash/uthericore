page 50512 "Approved Separation List"
{
    ApplicationArea = all;
    // version TL2.0

    Caption = 'Separation List';
    CardPageID = "Separation Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Separation;
    SourceTableView = WHERE("Separation Status" = filter('Processed'), Status = filter('Approved'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Separation No"; Rec."Separation No")
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
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Separation Type"; Rec."Separation Type")
                {
                    ApplicationArea = All;
                }
                field("Notification Start Date"; Rec."Notification Start Date")
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Notification End Date"; Rec."Notification End Date")
                {
                    ApplicationArea = All;
                }
                field("Last Working Date"; Rec."Last Working Date")
                {
                    ApplicationArea = All;
                }
                field("In Lieu of Notice"; Rec."In Lieu of Notice")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Error(Error000);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Error(Error001);
    end;

    var
        Error000: Label 'You cannot create a new record!';
        Error001: Label 'You cannot modify this record!';

}
