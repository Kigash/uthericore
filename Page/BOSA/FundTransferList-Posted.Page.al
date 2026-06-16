page 50224 "Fund Transfer List-Posted"
{
    // version TL2.0

    Caption = 'Posted Fund Transfers';
    CardPageID = "Fund Transfer";
    PageType = List;
    SourceTable = "Fund Transfer";
    SourceTableView = WHERE(Status = FILTER(Approved),
                        Posted = FILTER(true));
    UsageCategory = History;
    ApplicationArea = All;
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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = All;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = All;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = All;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = All;
                }
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
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        GLEntry: Record "G/L Entry";
    begin
        IF (Rec."Posting Date" = 0D) OR (Rec."Posted By" = '') then begin
            GLEntry.Reset();
            GLEntry.SetRange("Document No.", Rec."No.");
            if GLEntry.FindFirst() then begin
                Rec."Posting Date" := GLEntry."Posting Date";
                Rec."Posted By" := GLEntry."User ID";
                Rec.Modify();
            end;
        end;
    end;
}

