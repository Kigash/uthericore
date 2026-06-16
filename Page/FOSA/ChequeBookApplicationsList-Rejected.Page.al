page 50175 "Cheque Bk Appl. List-Rejected"
{
    // version TL2.0

    Caption = 'Rejected Cheque Book Applications';
    CardPageID = "Cheque Book Application";
    PageType = List;
    SourceTable = "Cheque Book Application";
    SourceTableView = WHERE(Status = FILTER(Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Member No."; Rec."Member No.")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Cheque Book No."; Rec."Cheque Book No.")
                {
                }
                field("Cheque Book S/No."; Rec."Cheque Book S/No.")
                {
                }
                field("No. of Leaves"; Rec."No. of Leaves")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Account Balance"; Rec."Account Balance")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

