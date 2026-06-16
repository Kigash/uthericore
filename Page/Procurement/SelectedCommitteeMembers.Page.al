page 50758 "Selected Committee Members"
{
    PageType = List;
    SourceTable = "Selected Committee Member";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Process No."; Rec."Process No.")
                {
                    ApplicationArea = All;
                }
                field("Committee Code"; Rec."Committee Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Process Stage"; Rec."Process Stage")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        SelectedCommitteeMember2: Record "Selected Committee Member";
        ProcurementManagement: Codeunit "Procurement Management";

    //[Scope('Personalization')]
    procedure SetSelection(SelectedCommitteeMember: Record "Selected Committee Member"; ProcessNo: Code[20]);
    begin
        SelectedCommitteeMember.RESET;
        CurrPage.SETSELECTIONFILTER(Rec);
        Rec.MARKEDONLY(TRUE);
        SelectedCommitteeMember.COPY(Rec);

        SelectedCommitteeMember2.RESET;
        SelectedCommitteeMember2.COPY(SelectedCommitteeMember);
        IF SelectedCommitteeMember2.FINDSET THEN BEGIN
            REPEAT
            UNTIL SelectedCommitteeMember2.NEXT = 0;
        END;
    end;

    local procedure UpdateSelectedCommiteeMembers(SelectedCommitteeMember: Record "Selected Committee Member"; ProcessNo: Code[20]);
    begin
    end;
}

