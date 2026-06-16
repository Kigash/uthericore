page 55041 "Grp Allocations List-Posted"
{
    // version MC2.0

    Caption = 'Posted Group Allocations';
    CardPageID = "Group Allocation";
    PageType = List;
    SourceTable = "Group Allocation Header";
    SourceTableView = WHERE(Status = FILTER(Approved),
                            Posted = FILTER(true));

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = All;
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Officer ID"; Rec."Loan Officer ID")
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

    trigger OnOpenPage()
    begin
        Variant2 := Rec;
        // MicroCreditManagement.ShowApprovalEntries(Variant2, 2);
        Rec.COPY(Variant2);
        Rec.SETRANGE(Posted, TRUE);
    end;

    var
        //MicroCreditManagement: Codeunit "55001";
        Variant2: Variant;
}

